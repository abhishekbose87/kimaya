require  File.dirname(__FILE__) + '/validator'

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
      :cho_calories, :cnr_rate, :calories, :non_protein,:dir_rate, :dextrose_10, :dextrose_50, :water, :heparin, :administration

    validates_each :day_of_tpn, :current_weight do |record, attr, value|
      record.errors.add attr, 'cant be blank' if value.blank?
    end

    def round(value, scale)
      "%.#{scale}f" % value
    end
  end
end

=begin
  @invalidValue = -1
  @invalidDayOfTPN = "1001"
  @invalidPercentDextroseConcentration = "1002"
  @invalidCurrentWeight = "1003"
  @invalidTotalFluidIntake = "1004"
  @invalidTotalFluidIntakeVolume = "1005"
  @invalidFeedVolume = "1006"
  @invalidLosses = "1007"
  @invalidTPNVolume = "1008"
  @invalidFATVolumeIntake = "1009"
  @invalidLipidConcentration = "1010"
  @invalidFATVolume = "1011"
  @invalidHAVSolution = "1012"
  @invalidOverfillFactor = "1013"
  @invalidPreparedOverfill = "1014"
  @invalidAminoAcidIntake = "1015"
  @invalidAminoAcidConcentration = "1016"
  @invalidAminoAcid = "1017"
  @invalidSodiumChlorideIntake = "1018"
  @invalidSodiumChlorideConcentration = "1019"
  @invalidSodiumChloride = "1020"
  @invalidPotassiumChlorideIntake = "1021"
  @invalidPotassiumChlorideConcentration = "1022"
  @invalidPotassiumChloride = "1023"
  @invalidCalciumIntake = "1024"
  @invalidCalciumConcentration = "1025"
  @invalidCalcium = "1026"
  @invalidMagnesiumIntake = "1027"
  @invalidMagnesiumConcentration = "1028"
  @invalidMagnesium = "1029"
  @invalidMVI = "1032"
  @invalidRemainingDextroseVolume = "1033"
  @invalidAchievedPercentDextroseConcentration = "1034"
  @invalidFATCalories = "1035"
  @invalidCHOCalories = "1036"
  @invalidCNRRate = "1037"
  @invalidProteinLevel = "1038"
  @invalidCalories = "1039"
  @invalidDIRRate = "1040"
  @invalidDextrose10 = "1041"
  @invalidDextrose50 = "1042"
  @invalidWater = "1043"
  @invalidHeparin = "1044"
=end
