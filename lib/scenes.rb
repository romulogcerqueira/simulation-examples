#!/usr/bin/ruby

module UnderwaterScenes
  SCENES = {
    'ssiv_bahia'    => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/ssiv_bahia/ssiv_bahia.world",
                        'position' => Eigen::Vector3.new(48.24, 103.48, -3.37),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(1.57, 0.524, 0), 2, 1, 0)},
    'tank'          => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/tank/tank.world",
                        'position' => Eigen::Vector3.new(48.24, 103.48, -3.37),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(1.57, 0.524, 0), 2, 1, 0)},
    'shipwreck'     => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/shipwreck/shipwreck.world",
                        'position' => Eigen::Vector3.new(-41.01, -62.50, -5),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(1.57, 0.524, 0), 2, 1, 0)}
  }
end