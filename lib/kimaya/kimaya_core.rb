module Kimaya
  module KimayaCore
    attr_accessor :day_of_tpn, :current_weight, 
      :percent_dextrose_conc, :total_fluid_intake, :total_fluid_intake_vol, :feed_vol, 
      :losses, :tpn_vol, :fat_intake, :fat_vol, :lipid_conc, :hav_vol, 
      :overfill_factor, :prepared_overfill,
      :amino_acid_intake, :amino_acid_conc, :amino_acid_vol,
      :sodium_chloride_intake, :sodium_chloride_conc, :sodium_chloride_vol,
      :potassium_chloride_intake, :potassium_chloride_conc, :potassium_chloride_vol,
      :calcium_intake, :calcium_conc, :calcium_vol,
      :magnesium_intake, :magnesium_conc, :magnesium_vol,
      :mvi, :remaining_dextrose_vol, :achieved_dextrose_conc, :fat_calories,
      :cho_calories, :cnr_rate, :calories, :total_protein,:dir_rate, :dextrose_concentrations, :water, :heparin, :administration, :non_protein,         :expected_dir, :available_dextrose_concentrations, :other_infusions

    attr_accessor :errors, :warnings
    def round(value, scale)
      ("%.#{scale}f" % value).to_f
    end

    ERROR_CODES = {
      percent_dextrose_conc: "1002", current_weight: "1003", total_fluid_intake: "1004", total_fluid_intake_vol: "1005",
      feed_vol: "1006", losses: "1007", tpn_vol: "1008", fat_intake: "1009", fat_vol: "1011", lipid_conc: "1010", 
      hav_vol: "1012", overfill_factor: "1013", prepared_overfill: "1014", amino_acid_intake: "1015", amino_acid_conc: "1016",
      amino_acid_vol: "1017", sodium_chloride_intake: "1018", sodium_chloride_conc: "1019", sodium_chloride_vol: "1020",
      potassium_chloride_intake: "1021", potassium_chloride_conc: "1022", potassium_chloride_vol: "1023", calcium_intake: "1024",
      calcium_conc: "1025", calcium_vol: "1026", magnesium_intake: "1027", magnesium_conc: "1028", magnesium_vol: "1029",
      mvi: "1032", remaining_dextrose_vol: "1033", achieved_dextrose_conc: "1034", fat_calories: "1035", cho_calories: "1036",
      cnr_rate: "1037", calories: "1039", dir_rate: "1040", dextrose_10: "1041", dextrose_50: "1042", heparin: "1044"
    }
  end
end

