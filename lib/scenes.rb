#!/usr/bin/ruby

module UnderwaterScenes
  SCENES = {
    'ssiv_bahia'    => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/ssiv_bahia/ssiv_bahia.world",
                        'position' => Eigen::Vector3.new(48.24, 103.48, -3.37),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(1.57, 0.524, 0), 2, 1, 0)},
    'tank'          => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/tank/tank.world",
                        'position' => Eigen::Vector3.new(48.24, 103.48, -3.37),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(1.57, 0.524, 0), 2, 1, 0)},
    # FLS: range = 33m, gain = 42%
    'ferry'         => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/shipwreck/shipwreck.world",
                        'position' => Eigen::Vector3.new(-42.64, -61.18, -8.0),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(1.36, 0.35, 0), 2, 1, 0)},
    # FLS: range = 15m, gain = 42%
    'pipeline'      => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/maria_layout/maria_layout.world",
                        'position' => Eigen::Vector3.new(-1420, 1447, -84),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(2.33, 0.35, 0), 2, 1, 0)},
    # FLS: range = 50m, gain = 65%
    'maria_layout'  => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/maria_layout/maria_layout.world",
                        'position' => Eigen::Vector3.new(-1394, 1465, -76),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(4.5, 0.35, 0), 2, 1, 0)},
    # FLS: range = 30m, gain = 50%
    'maria_layout2' => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/maria_layout/maria_layout.world",
                        'position' => Eigen::Vector3.new(-1445, 1455, -84),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(4.71, -1.57, 0), 2, 1, 0)},
    # MSIS: range = 60m, gain = 65%
    'shipwreck'     => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/shipwreck/shipwreck.world",
                        'position' => Eigen::Vector3.new(-14, -24.40, -5),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(0, 0, 0), 2, 1, 0)},

    # MSIS: range = 60m, gain = 65%
    'mega_structure'     => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/mega_structure/mega_structure.world",
                        'position' => Eigen::Vector3.new(0, 0, 0),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(0, 0, 0), 2, 1, 0)},

  }
end