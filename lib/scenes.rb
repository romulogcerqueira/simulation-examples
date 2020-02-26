#!/usr/bin/ruby

module UnderwaterScenes
  SCENES = {
    'ssiv_bahia'    => {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/ssiv_bahia/ssiv_bahia.world",
                        'position' => Eigen::Vector3.new(49.34, 106.01, -5.87),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(1.94, 0.524, 0), 2, 1, 0)},

    'mega_structure'=> {'world' => "#{ENV['AUTOPROJ_CURRENT_ROOT']}/simulation/uwmodels/scenes/mega_structure/mega_structure.world",
                        'position' => Eigen::Vector3.new(0, 0, 0),
                        'orientation' => Eigen::Quaternion.from_euler(Eigen::Vector3.new(0, 0, 0), 2, 1, 0)},
}
end