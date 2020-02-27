require 'rock/bundles'
require 'orocos'
require_relative "./lib/common.rb"
require_relative "./lib/scenes.rb"
require_relative "./lib/pose_control.rb"
require_relative './lib/rock_gazebo'
require_relative './lib/rock_viz'

include Orocos

Rock::Gazebo.initialize
_, argv = Rock::Gazebo.resolve_worldfiles_and_models_arguments(ARGV)

@world = UnderwaterScenes::SCENES['mega_structure']
@scene = @world['world']

Orocos.run 'imaging_sonar_simulation::ScanningSonarTask' => 'sonar_scanning' do
    # Initial pose
    @sonar_pose = Types.base.samples.RigidBodyState.new
    @sonar_pose.targetFrame = "world"
    @sonar_pose.sourceFrame = "sonar_scanning"
    @sonar_pose.position = @world['position']
    @sonar_pose.orientation = @world['orientation']

    # Start the orocos task
    task = TaskContext.get 'sonar_scanning'
    timeout = 100
    setup_task(task, timeout)

    # Start the Rock widgets
    buffer = 5
    setup_widgets(task, buffer)
end