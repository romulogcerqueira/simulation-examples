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

@world = UnderwaterScenes::SCENES['ferry']
@scene = @world['world']

Orocos.run 'imaging_sonar_simulation::MultibeamSonarTask' => 'sonar_multibeam' do
    # Initial pose
    @sonar_pose = Types.base.samples.RigidBodyState.new
    @sonar_pose.targetFrame = "world"
    @sonar_pose.sourceFrame = "sonar_multibeam"
    @sonar_pose.position = @world['position']
    @sonar_pose.orientation = @world['orientation']

    # Orocos.log_all

    # Start the orocos task
    task = TaskContext.get 'sonar_multibeam'
    timeout = 100
    setup_task(task, timeout)

    # Start the Rock widgets
    buffer = 1
    setup_widgets(task, buffer)
end