require 'rock/bundles'
require_relative "./lib/common"
require_relative "./lib/pose_control"
require_relative './lib/rock_gazebo'
require_relative './lib/rock_viz'

include Orocos

Rock::Gazebo.initialize
_, argv = Rock::Gazebo.resolve_worldfiles_and_models_arguments(ARGV)

@scene = "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/ssiv_bahia/ssiv_bahia.world"

Orocos.run 'imaging_sonar_simulation::MultibeamSonarTask' => 'sonar_multibeam' do
    # Initial pose
    @sonar_pose = Types.base.samples.RigidBodyState.new
    @sonar_pose.targetFrame = "world"
    @sonar_pose.sourceFrame = "sonar_multibeam"
    @sonar_pose.position = Eigen::Vector3.new(48.24, 103.48, -3.37)
    @sonar_pose.orientation = Eigen::Quaternion.from_euler(Eigen::Vector3.new(1.57, 0.524, 0), 2, 1, 0)

    # Start the orocos task
    task = TaskContext.get 'sonar_multibeam'
    timeout = 100
    setup_task(task, timeout)

    # Start the Rock widgets
    buffer = 1
    setup_widgets(task, buffer)
end
