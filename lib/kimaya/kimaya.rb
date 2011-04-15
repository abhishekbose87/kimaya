module Kimaya
  class TPNCalc

    include ActiveModel::Validations
    include ActiveModel::Conversion
    #extend ActiveModel::Naming
    include KimayaCore
    #validates_with TPNValidator 

    validates :day_of_tpn, :presence => {:message => "You have entered an invalid value for Day of TPN, please enter the correct value."}
    validates :current_weight, :percent_dextrose_conc, :total_fluid_intake, :fat_intake, :lipid_conc, :overfill_factor,
      :amino_acid_intake, :amino_acid_conc, :presence => true

    def initialize(options= {})
      @day_of_tpn = initialize_key(options, :day_of_tpn, 1, 1)
      @current_weight = initialize_key(options, :current_weight, 2) 
      @percent_dextrose_conc = initialize_key(options, :percent_dextrose_conc, 4) 
      @total_fluid_intake =  initialize_key(options, :total_fluid_intake, 2) 
      @losses = initialize_key(options, :losses, 2)
      @fat_intake = initialize_key(options, :fat_intake, 2)
      @lipid_conc = initialize_key(options, :lipid_conc, 2)
      @overfill_factor = initialize_key(options, :overfill_factor, 2)
      @amino_acid_intake = initialize_key(options, :amino_acid_intake, 3)
      @amino_acid_conc = initialize_key(options, :amino_acid_conc, 3)
      @sodium_chloride_intake = initialize_key(options, :sodium_chloride_intake, 3, 0)
      @sodium_chloride_conc = initialize_key(options, :sodium_chloride_conc, 3, 1)
      @potassium_chloride_intake = initialize_key(options, :potassium_chloride_intake, 3, 0)
      @potassium_chloride_conc = initialize_key(options, :potassium_chloride_conc, 3, 1)
      @magnesium_intake = initialize_key(options, :magnesium_intake, 3, 0)
      @magnesium_conc = initialize_key(options, :magnesium_conc, 3, 1)
      @calcium_intake = initialize_key(options, :calcium_intake, 3, 0)
      @calcium_conc = initialize_key(options, :calcium_conc, 3, 1)
      @administration = options.has_key?(:administration) ? options.fetch(:administration) : nil
      @feed_vol = @losses = 0
    end

    def calculate_tpn 
      calculate_volumes
      calculate_additives
      calculate_dextrose_concentration_achieved
      calculate_calories
    end

    private

    def calculate_volumes
      @total_fluid_intake_vol = round(total_fluid_intake * current_weight, 2)
      @tpn_vol = round(total_fluid_intake_vol - feed_vol + losses, 2)
      @fat_vol = round(fat_intake * current_weight / lipid_conc, 2) 
      @hav_vol = round(tpn_vol - fat_vol, 2)
      @prepared_overfill = round(hav_vol * overfill_factor, 2)
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
      @fat_calories = round(lipid_conc == 0.1 ? fat_vol : fat_vol * 2, 2)
      @cho_calories = round(((dextrose_10 / 10) + (dextrose_50 / 2)) * 3.4, 2)
      @cnr_rate = round(((fat_calories + cho_calories)/ (amino_acid_intake * current_weight)) * 6.25, 2)
      
      tempAminoAcid = amino_acid_vol / overfill_factor
      @calories = round(fat_calories + cho_calories + (tempAminoAcid * amino_acid_conc * 4), 2)
      @non_protein= round(calories - (tempAminoAcid * amino_acid_conc * 4), 2)
      
      @dir_rate = round(((hav_vol * percent_dextrose_conc) / (24 * 60 * current_weight)) * 1000, 2)
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
      @achieved_dextrose_conc = round(old_val, 2)
      @dextrose_50 = round(@dextrose_50, 2)
      @dextrose_10 = round(@dextrose_10, 2)
      @water = round(@water, 2)
    end


    def volume(intake, conc)
      round(intake * @current_weight * @overfill_factor / conc, 2)
    end

    def total_additives
      @heparin = administration == "Central Line" ? round(prepared_overfill / 1000, 2) : 0
      amino_acid_vol + sodium_chloride_vol + potassium_chloride_vol + calcium_vol + magnesium_vol + mvi + heparin
    end

    def initialize_key(options, key, scale, default_value = nil)
      options.has_key?(key) ? round(options.fetch(key), scale) : default_value
    end
  end
end
