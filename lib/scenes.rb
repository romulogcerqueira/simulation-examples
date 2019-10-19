#!/usr/bin/ruby

module UnderwaterScenes
  SCENES = {
    'ssiv_bahia'    => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/ssiv_bahia/ssiv_bahia.world",
                        'position' => Eigen::Vector3.new(48.24, 103.48, -3.37),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(1.57, 0.524, 0), 2, 1, 0)},

    # MSIS: range = 28m, gain = 15% / paper similarity evaluation
    'tank'          => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/tank/tank.world",
                        'position' => Eigen::Vector3.new(10.5, 9.63, -0),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(-0.26, 0, 0), 2, 1, 0)},

    # FLS: range = 33m, gain = 42%
    'ferry'         => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/wrecks/wrecks.world",
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

    # MSIS: range = 30m, gain = 65%
    'wrecks'     => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/wrecks/wrecks.world",
                        'position' => Eigen::Vector3.new(-37.80, -39.94, -8),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(-1.79, 0.33, 0), 2, 1, 0)},

    # MSIS: range = 7m, gain = 50%
    'mega_structure'=> {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/mega_structure/mega_structure.world",
                        'position' => Eigen::Vector3.new(0, 0, 0),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(0, 0, 0), 2, 1, 0)},

    # FLS: range = 11m, gain = 65%
    'car_fls'       => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/wrecks/wrecks.world",
                        'position' => Eigen::Vector3.new(-17.90, 16.07, -10.37),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(2.09, 0.35, 0), 2, 1, 0)},

    # MSIS: range = 7m, gain = 70%
    'car_msis'      => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/wrecks/wrecks.world",
                        'position' => Eigen::Vector3.new(-18.90, 17.81, -11.37),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(2.09, 0, 0), 2, 1, 0)},

    # FLS: range = 16m, gain = 50%
    'ssiv_bahia_eval'   => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/ssiv_bahia/ssiv_bahia.world",
                        'position' => Eigen::Vector3.new(49.34, 106.01, -5.87),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(1.94, 0.52, 0), 2, 1, 0)},

    # MSIS: range = 28m, gain = 15% / paper similarity evaluation
    'tank_eval'         => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/tank/tank.world",
                        'position' => Eigen::Vector3.new(10.5, 9.63, -0),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(-0.30, 0, 0), 2, 1, 0)},

    # FLS: range: 49m, gain = 70% / big picture with shader image
    'maria_layout_fls' => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/maria_layout/maria_layout.world",
                        'position' => Eigen::Vector3.new(-1392, 1460, -77),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(2.01, 0.35, 0), 2, 1, 0)},

    # MSIS: range: 46m, gain = 48% / big picture with shader image
    'maria_layout_msis' => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/maria_layout/maria_layout.world",
                        'position' => Eigen::Vector3.new(-1394, 1465, -84),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(-1.78, 0, 0), 2, 1, 0)},

    # FLS: range: 49m, gain = 70% / big picture with shader image
    'galleon' => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/wrecks/wrecks.world",
                        'position' => Eigen::Vector3.new(4.06, -7.26, -9),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(4.22, 0.33, 0), 2, 1, 0)},

    # FLS: range: 39m, gain = 58%
    'xmastree_fls' => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/maria_layout/maria_layout.world",
                        'position' => Eigen::Vector3.new(-1439, 1457, -77),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(-2.88, 0.44, 0), 2, 1, 0)},

}
end