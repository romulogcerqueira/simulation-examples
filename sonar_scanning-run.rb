require 'rock/bundles'
require_relative "./lib/common.rb"
require_relative "./lib/pose_control.rb"
require_relative './lib/rock_gazebo'
require_relative './lib/rock_viz'

include Orocos

Rock::Gazebo.initialize
_, argv = Rock::Gazebo.resolve_worldfiles_and_models_arguments(ARGV)

@scene = "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/ssiv_bahia/ssiv_bahia.world"

Orocos.run 'imaging_sonar_simulation::ScanningSonarTask' => 'sonar_scanning' do
    # Initial pose
    @sonar_pose = Types.base.samples.RigidBodyState.new
    @sonar_pose.targetFrame = "world"
    @sonar_pose.sourceFrame = "sonar_scanning"
    @sonar_pose.position = Eigen::Vector3.new(41.0, 110.10, -10)
    @sonar_pose.orientation = Eigen::Quaternion.from_euler(Eigen::Vector3.new(0, 0, 0), 2, 1, 0)

    # Start the orocos task
    task = TaskContext.get 'sonar_scanning'
    timeout = 10
    setup_task(task, timeout)

    # Start the Rock widgets
    buffer = 30
    setup_widgets(task, buffer)
end