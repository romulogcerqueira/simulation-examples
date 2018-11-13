require 'vizkit'
require_relative './rock_gazebo'
require 'transformer/sdf'

module RockGazebo
    # Library-side implementation of rock-gazebo-viz
    def self.viz(scene, env: nil, start: true, vizkit3d: Vizkit.vizkit3d_widget)
        _, scene = Rock::Gazebo.resolve_worldfiles_and_models_arguments([scene])
        scene = scene.first
        models = Viz.setup_scene(scene, vizkit3d: vizkit3d)
        if env
            if env.respond_to?(:to_str) # this is a plugin name
                env = Vizkit.default_loader.send(env)
            end
            vizkit3d.setEnvironmentPlugin(env)
        end

        if start
            models.each do |model, (_, task_proxy)|
                task_proxy.on_reachable do
                    begin
                        if task_proxy.rtt_state == :PRE_OPERATIONAL
                            task = Orocos.get(task_proxy.name)
                            begin
                                Orocos.conf.apply(task, ['default', model.name])
                                STDERR.puts "#{task_proxy.name}: applied configuration section #{model.name}"
                            rescue Orocos::TaskConfigurations::SectionNotFound => e
                                STDERR.puts "#{task_proxy.name}: section #{model.name} not found, applying only default configuration (#{e.message})"
                                Orocos.conf.apply(task, ['default'])
                            end
                            task.world_frame = 'world'
                            task_proxy.configure
                        end

                        if task_proxy.rtt_state == :STOPPED
                            task_proxy.start
                        end

                        state = task_proxy.rtt_state
                        if state != :RUNNING
                            STDERR.puts "could not start #{task_proxy.name} (currently in state #{state})"
                        end
                    rescue Exception => e
                        STDERR.puts "failed to start #{task_proxy.name}: #{e}"
                    end
                end
            end
        end
        models
    end

    module Viz
        # Sets up the visualization of a complete gazebo scene to a vizkit3d
        # widget
        #
        # @param [SDF::Element] scene the scene
        # @return [{SDF::Model=>(RobotVisualization,Orocos::Async::TaskContext)]] a
        #   mapping from a model name to the vizkit3d plugin and task proxy that
        #   represent it
        def self.setup_scene(scene_path, vizkit3d: Vizkit.vizkit3d_widget,
                             task_name_mapping: default_task_name_mapping)
            models = Hash.new
            sdf = SDF::Root.load(scene_path)
            world = sdf.each_world.first

            conf = Transformer::Configuration.new
            conf.load_sdf(scene_path)
            conf.rename_frames world.name => 'world'
            conf.static_transform Eigen::Vector3.Zero, world.name => 'world'
            vizkit3d.apply_transformer_configuration(conf)

            sdf.each_model(recursive: true) do |model|
                parent_frame_name =
                    if model.parent == world
                        'world'
                    else
                        model.parent.full_name
                    end

                models[model] = setup_model(conf, model, vizkit3d: vizkit3d, dir: File.dirname(scene_path),
                                            frame_name: model.name,
                                            parent_frame_name: parent_frame_name,
                                            task_name_mapping: task_name_mapping)
            end
            vizkit3d.setRootFrame('world')
            models
        end

        def self.vizkit3d_update_transforms_from_sdf(scene_path, vizkit3d: Vizkit.vizkit3d_widget)
            sdf = SDF::Root.load(scene_path)
            world = sdf.each_world.first

            conf = Transformer::Configuration.new
            conf.load_sdf(scene_path)
            conf.rename_frames world.name => 'world'
            conf.static_transform Eigen::Vector3.Zero, world.name => 'world'
            vizkit3d.apply_transformer_configuration(conf)
        end

        def self.default_task_name_mapping
            lambda { |model| "gazebo:#{model.full_name.gsub('::', ':')}" }
        end

        # @api private
        #
        # The name of the parent frame for a given model
        def self.default_parent_frame_name(model)
            if parent = model.parent
                parent.full_name
            else 'osg_world'
            end
        end

        # Sets up the visualization of a single model
        #
        # @param [SDF::Model] model the model
        # @return [(RobotVisualization,Orocos::Async::TaskContext)] the vizkit3d
        #   plugin and the async task for this model
        def self.setup_model(transformer_conf, model, vizkit3d: Vizkit.vizkit3d_widget, dir: nil,
                             frame_name: model.name,
                             parent_frame_name: default_parent_frame_name(model),
                             task_name_mapping: default_task_name_mapping)
            model_viz = Vizkit.default_loader.RobotVisualization
            model_viz.setPluginName(model.full_name)

            model_only = model.make_root
            model_viz.loadFromString(model_only.xml.to_s, 'sdf', dir)
            model_viz.frame = frame_name

            if task_name = task_name_mapping[model]
                puts "listening to #{task_name} for #{model.name}"
                task_proxy = Orocos::Async.proxy task_name
                trsf = transformer_conf.dynamic_transform "#{task_name}.pose_samples",
                    frame_name => parent_frame_name
                vizkit3d.listen_to_transformation_producer(trsf)
                joints_out = task_proxy.port "joints_samples"

                joints_out.on_data do |sample|
                    model_viz.updateData(sample)
                end
            end

            return model_viz, task_proxy
        end
    end
end

