module Kimaya
  class TPNCalc

    include ActiveModel::Validations
    include ActiveModel::Conversion
    #extend ActiveModel::Naming
    include KimayaCore
    #validates_with TPNValidator 

    validates :day_of_tpn, :presence => {:message => :day_of_tpn_blank}

    def initialize(options= {})
      @day_of_tpn = options.fetch(:day_of_tpn, 1)
    end

    def DayOfTPN
      if @dayOfTPN <= @invalidValue then
        raise Exception.new(@invalidDayOfTPN)
      end
      return @dayOfTPN
    end

    def DayOfTPN=(value)
      @dayOfTPN = value
    end

    def PercentDextroseConcentration
      if @percentDextroseConcentration <= @invalidValue then
        raise Exception.new(@invalidPercentDextroseConcentration)
      end
      return round(@percentDextroseConcentration, 4)
    end

    def PercentDextroseConcentration=(value)
      @percentDextroseConcentration = value
    end

    def CurrentWeight
      if @currentWeight <= @invalidValue then
        raise Exception.new(@invalidCurrentWeight)
      end
      return round(@currentWeight, 2)
    end

    def CurrentWeight=(value)
      @currentWeight = value
    end

    def TotalFluidIntake
      if @totalFluidIntake <= @invalidValue then
        raise Exception.new(@invalidTotalFluidIntake)
      end
      return round(@totalFluidIntake, 2)
    end

    def TotalFluidIntake=(value)
      @totalFluidIntake = value
    end

    def TotalFluidIntakeVolume
      if @totalFluidIntakeVolume <= @invalidValue then
        raise Exception.new(@invalidTotalFluidIntakeVolume)
      end
      return round(@totalFluidIntakeVolume, 2)
    end

    def FeedVolume
      if @feedVolume <= @invalidValue then
        raise Exception.new(@invalidFeedVolume)
      end
      return round(@feedVolume, 2)
    end

    def FeedVolume=(value)
      @feedVolume = value
    end

    def Losses
      if @losses <= @invalidValue then
        raise Exception.new(@invalidLosses)
      end
      return round(@losses, 2)
    end

    def Losses=(value)
      @losses = value
    end

    def TPNVolume
      if @tpnVolume <= @invalidValue then
        raise Exception.new(@invalidTPNVolume)
      end
      return round(@tpnVolume, 2)
    end

    def FATVolumeIntake
      if @fatVolumeIntake <= @invalidValue then
        raise Exception.new(@invalidFATVolumeIntake)
      end
      return round(@fatVolumeIntake, 2)
    end

    def FATVolumeIntake=(value)
      @fatVolumeIntake = value
    end

    def LipidConcentration
      if @lipidConcentration <= @invalidValue then
        raise Exception.new(@invalidLipidConcentration)
      end
      return round(@lipidConcentration, 2)
    end

    def LipidConcentration=(value)
      @lipidConcentration = value
    end

    def FATVolume
      if @fatVolume <= @invalidValue then
        raise Exception.new(@invalidFATVolume)
      end
      return round(@fatVolume, 2)
    end

    def HAVSolution
      if @havSolution <= @invalidValue then
        raise Exception.new(@invalidHAVSolution)
      end
      return round(@havSolution, 2)
    end

    def OverfillFactor
      if @overfillFactor <= @invalidValue then
        raise Exception.new(@invalidOverfillFactor)
      end
      return round(@overfillFactor, 2)
    end

    def OverfillFactor=(value)
      @overfillFactor = value
    end

    def PreparedOverfill
      if @preparedOverfill <= @invalidValue then
        raise Exception.new(@invalidPreparedOverfill)
      end
      return round(@preparedOverfill, 2)
    end

    def AminoAcidIntake
      if @aminoAcidIntake <= @invalidValue then
        raise Exception.new(@invalidAminoAcidIntake)
      end
      return round(@aminoAcidIntake, 2)
    end

    def AminoAcidIntake=(value)
      @aminoAcidIntake = value
    end

    def AminoAcidConcentration
      if @aminoAcidConcentration <= @invalidValue then
        raise Exception.new(@invalidAminoAcidConcentration)
      end
      return round(@aminoAcidConcentration, 3)
    end

    def AminoAcidConcentration=(value)
      @aminoAcidConcentration = value
    end

    def AminoAcid
      if @aminoAcid <= @invalidValue then
        raise Exception.new(@invalidAminoAcid)
      end
      return round(@aminoAcid, 2)
    end

    def SodiumChlorideIntake
      if @sodiumChlorideIntake <= @invalidValue then
        raise Exception.new(@invalidSodiumChlorideIntake)
      end
      return round(@sodiumChlorideIntake, 3)
    end

    def SodiumChlorideIntake=(value)
      @sodiumChlorideIntake = value
    end

    def SodiumChlorideConcentration
      if @sodiumChlorideConcentration <= @invalidValue then
        raise Exception.new(@invalidSodiumChlorideConcentration)
      end
      return round(@sodiumChlorideConcentration, 3)
    end

    def SodiumChlorideConcentration=(value)
      @sodiumChlorideConcentration = value
    end

    def SodiumChloride
      if @sodiumChloride <= @invalidValue then
        raise Exception.new(@invalidSodiumChloride)
      end
      return round(@sodiumChloride, 2)
    end

    def PotassiumChlorideIntake
      if @potassiumChlorideIntake <= @invalidValue then
        raise Exception.new(@invalidPotassiumChlorideIntake)
      end
      return round(@potassiumChlorideIntake, 2)
    end

    def PotassiumChlorideIntake=(value)
      @potassiumChlorideIntake = value
    end

    def PotassiumChlorideConcentration
      if @potassiumChlorideConcentration <= @invalidValue then
        raise Exception.new(@invalidPotassiumChlorideConcentration)
      end
      return round(@potassiumChlorideConcentration, 3)
    end

    def PotassiumChlorideConcentration=(value)
      @potassiumChlorideConcentration = value
    end

    def PotassiumChloride
      if @potassiumChloride <= @invalidValue then
        raise Exception.new(@invalidPotassiumChloride)
      end
      return round(@potassiumChloride, 2)
    end

    def CalciumIntake
      if @calciumIntake <= @invalidValue then
        raise Exception.new(@invalidCalciumIntake)
      end
      return round(@calciumIntake, 2)
    end

    def CalciumIntake=(value)
      @calciumIntake = value
    end

    def CalciumConcentration
      if @calciumConcentration <= @invalidValue then
        raise Exception.new(@invalidCalciumConcentration)
      end
      return round(@calciumConcentration, 3)
    end

    def CalciumConcentration=(value)
      @calciumConcentration = value
    end

    def Calcium
      if @calcium <= @invalidValue then
        raise Exception.new(@invalidCalcium)
      end
      return round(@calcium, 2)
    end

    def MagnesiumIntake
      if @magnesiumIntake <= @invalidValue then
        raise Exception.new(@invalidMagnesiumIntake)
      end
      return round(@magnesiumIntake, 2)
    end

    def MagnesiumIntake=(value)
      @magnesiumIntake = value
    end

    def MagnesiumConcentration
      if @magnesiumConcentration <= @invalidValue then
        raise Exception.new(@invalidMagnesiumConcentration)
      end
      return round(@magnesiumConcentration, 3)
    end

    def MagnesiumConcentration=(value)
      @magnesiumConcentration = value
    end

    def Magnesium
      if @magnesium <= @invalidValue then
        raise Exception.new(@invalidMagnesium)
      end
      return round(@magnesium, 2)
    end

    def MVIIntake
      if @mviIntake <= @invalidValue then
        raise Exception.new(@invalidMVI)
      end
      return round(@mviIntake, 2)
    end

    def MVI
      if @mvi <= @invalidValue then
        raise Exception.new(@invalidMVI)
      end
      return round(@mvi, 2)
    end

    def SumOfAdditives
      return round(self.CaculateSumOfAdditives, 2)
    end

    def RemainingDextroseVolume
      if @remainingDextroseVolume <= @invalidValue then
        raise Exception.new(@invalidRemainingDextroseVolume)
      end
      return round(@remainingDextroseVolume, 2)
    end

    def AchievedPercentDextroseConcentration
      if @achievedPercentDextroseConcentration <= @invalidValue then
        raise Exception.new(@invalidAchievedPercentDextroseConcentration)
      end
      return round(@achievedPercentDextroseConcentration, 4)
    end

    def FATCalories
      if @fatCalories <= @invalidValue then
        raise Exception.new(@invalidFATCalories)
      end
      return round(@fatCalories, 2)
    end

    def CHOCalories
      if @choCalories <= @invalidValue then
        raise Exception.new(@invalidCHOCalories)
      end
      return round(@choCalories, 2)
    end

    def CNRRate
      if @cnrRate <= @invalidValue then
        raise Exception.new(@invalidCNRRate)
      end
      return round(@cnrRate, 2)
    end

    def Calories
      if @calories <= @invalidValue then
        raise Exception.new(@invalidCalories)
      end
      return round(@calories)
    end

    def DIRRate
      if @dirRate <= @invalidValue then
        raise Exception.new(@invalidDIRRate)
      end
      return round(@dirRate, 2)
    end

    def Dextrose50
      if @dextrose50 <= @invalidValue then
        raise Exception.new(@invalidDextrose50)
      end
      return round(@dextrose50, 2)
    end

    def Dextrose10
      if @dextrose10 <= @invalidValue then
        raise Exception.new(@invalidDextrose10)
      end
      return round(@dextrose10, 2)
    end

    def Water
      if @water <= @invalidValue then
        raise Exception.new(@invalidWater)
      end
      return round(@water, 2)
    end

    def Heparin
      if @heparin <= @invalidValue then
        raise Exception.new(@invalidHeparin)
      end
      return round(@heparin, 2)
    end

    def Heparin=(value)
      @heparin = value
    end

    def Administration
      return @administration
    end

    def Administration=(value)
      @administration = value.to_s
    end


    def calculate_tpn 
      calculate_volumes
      calculate_additives
      calculate_dextrose_concentration_achieved
      calculate_calories
    end

    private

    def validate_tpn_inputs
    end

    def calculate_volumes
      @total_fluid_intake_vol = total_fluid_intake * current_weight
      @tpn_vol = total_fluid_intake_vol - feed_vol + losses
      @fat_vol = fat_intake * current_weight / lipid_conc 
      @hav_vol = tpn_vol - fat_vol
      @prepared_overfill = hav_vol * overfill_factor
    end

    def calculate_additives
      @amino_acid_vol = volume(amino_acid_intake, amino_acid_conc) 
      @sodium_chloride_vol = volume(sodium_chloride_intake, sodium_chloride_conc)
      @potassium_chloride_vol = volume(potassium_chloride_intake, potassium_chloride_conc)
      @calcium_vol = volume(calcium_intake, calcium_conc)
      @magnesium_vol = volume(magnesium_intake, magnesium_conc)
      @mvi = 0.5 * current_weight
      @remaining_dextrose_vol = prepared_overfill - total_additives 
    end

    def calculate_calories
      @fat_calories = lipid_conc == 0.1 ? fat_vol : fat_vol * 2
      @cho_calories = ((dextrose_10 / 10) + (dextrose_50 / 2)) * 3.4
      @cnr_rate = ((fat_calories + cho_calories)/ (amino_acid_intake * current_weight)) * 6.25
      
      tempAminoAcid = amino_acid_vol / overfill_factor
      @calories = fat_calories + cho_calories + (tempAminoAcid * amino_acid_conc * 4)
      @non_protein= calories - (tempAminoAcid * amino_acid_conc * 4)
      
      @dir_rate = ((hav_vol * percent_dextrose_conc) / (24 * 60 * current_weight)) * 1000
    end

    def calculate_dextrose_concentration_achieved 
      remain_volume = remaining_dextrose_vol 
      overfill = prepared_overfill 
      dextrose_concentration = percent_dextrose_conc 
      wanted_dextrose_vol = overfill 
      achieved_dextrose_concentration = 0.0
      old_val = 1
      old_dex_50 = @dextrose_50 = 1
      @water = 0

      if wanted_dextrose_vol < remain_volume then
        achieved_dextrose_concentration = dextrose_concentration
        @dextrose_10 = wanted_dextrose_vol * 10
        @dextrose_50 = 0
        @water = remain_volume - wanted_dextrose_vol * 10
      elsif wanted_dextrose_vol - remain_volume < 2 then
        achieved_dextrose_concentration = ((wanted_dextrose_vol - ((wanted_dextrose_vol * 10 - remain_volume) / 10)) * dextrose_concentration) / (wanted_dextrose_vol * dextrose_concentration)
        @dextrose_10 = remain_volume
        @dextrose_50 = 0
        @water = 0
      else
        while achieved_dextrose_concentration < dextrose_concentration
          old_val = achieved_dextrose_concentration
          old_dex_50 = dextrose_50 
          @dextrose_10 = remain_volume - dextrose_50
          if dextrose_10 < 0 then
            raise Exception.new(t("1041"))
          end
          @dextrose_50 = dextrose_50 / 2
          @dextrose_10 = dextrose_10 / 10
          achieved_dextrose_concentration = dextrose_50 + dextrose_10 
          achieved_dextrose_concentration = achieved_dextrose_concentration * dextrose_concentration / (dextrose_concentration * overfill)
          @dextrose_50 = old_dex_50 + 1
        end
        @dextrose_50 = old_dex_50 
        @dextrose_10 = remain_volume - dextrose_50

      end
      @achieved_dextrose_conc = old_val 
    end


    def volume(intake, conc)
      intake * current_weight * overfill_factor / conc
    end

    def total_additives
      @heparin = administration == "Central Line" ? prepared_overfill / 1000 : 0
      amino_acid_vol + sodium_chloride_vol + potassium_chloride_vol + calcium_vol + magnesium_vol + mvi + heparin
    end

  end
end
