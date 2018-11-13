require 'vizkit'

def setup_task(task, timeout)
    # Load configuration settings
    Orocos.conf.load_dir("#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/examples/config/")
    Orocos.conf.apply(task, ['default'], :override => true)

    # Load underwater scene
    task.world_file_path = @scene
    task.configure

    # Write the sonar pose
    timer = Qt::Timer.new
    timer.connect(SIGNAL('timeout()')) do
        task.sonar_pose_cmd.write @sonar_pose
    end

    # Start the task
    timer.start(timeout)
    task.start
end

def set_view_pose(vizkit3d)
    # Convert Rock to Osg pose
    look_at = @sonar_pose.position + @sonar_pose.orientation * Eigen::Vector3.UnitX
    up      = @sonar_pose.orientation * Eigen::Vector3.UnitZ
    eye     = @sonar_pose.position
    vizkit3d.setCameraEye(eye[0], eye[1], eye[2])
    vizkit3d.setCameraLookAt(look_at[0], look_at[1], look_at[2])
    vizkit3d.setCameraUp(up[0], up[1], up[2])
end

def setup_widgets(task, buffer)
    # Set the sonar widget
    sonar_gui = Vizkit.default_loader.SonarWidget
    sonar_gui.setGain(task.gain * 100.0)
    sonar_gui.setRange(task.range)
    sonar_gui.setMaxRange(150)
    sonar_gui.setSonarPalette(1)

    sonar_gui.connect(SIGNAL('gainChanged(int)')) do |value|
        task.property("gain").write value / 100.0
    end
    sonar_gui.connect(SIGNAL('rangeChanged(int)')) do |value|
        task.property("range").write value
    end

    # Connect the components
    task.sonar_samples.connect_to sonar_gui, type: :buffer, size: buffer

    # Set the task inspector
    task_inspector = Vizkit.default_loader.TaskInspector
    Vizkit.display task, :widget => task_inspector

    # Set the vizkit3d
    RockGazebo::Viz.setup_scene(@scene)
    vizkit3d = Vizkit.vizkit3d_widget
    env = Vizkit.default_loader.Ocean()
    vizkit3d.setEnvironmentPlugin(env)
    set_view_pose(vizkit3d)

    # Pose control
    pose_gui = PoseControl.new(@sonar_pose)
    pose_gui.connect(SIGNAL(:sonar_pose_changed)) do
        @sonar_pose = pose_gui.current_sonar_pose
        set_view_pose(vizkit3d)
    end

    # Start the Rock widgets
    begin
        sonar_gui.show
        pose_gui.show
        Vizkit.exec
    rescue Interrupt => e
        task.stop
        task.cleanup
    end
end