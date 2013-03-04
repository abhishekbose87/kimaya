module Kimaya
  class TPNCalc
    include KimayaCore

    MAX_DIR = 12.0
    MIN_CNR = 150.0

    def initialize(options= {}, &block)
      yield self if block_given?

      @day_of_tpn                ||= initialize_key(options, :day_of_tpn, 1, 1)
      @current_weight            ||= initialize_key(options, :current_weight, 2) 
      @percent_dextrose_conc     ||= initialize_key(options, :percent_dextrose_conc, 4, 0.1) 
      @total_fluid_intake        ||= initialize_key(options, :total_fluid_intake, 2, 0) 
      @losses                    ||= initialize_key(options, :losses, 2)
      @fat_intake                ||= initialize_key(options, :fat_intake, 2, 0)
      @lipid_conc                ||= initialize_key(options, :lipid_conc, 2, 0.1)
      @overfill_factor           ||= initialize_key(options, :overfill_factor, 2, 1.0)
      @amino_acid_intake         ||= initialize_key(options, :amino_acid_intake, 3)
      @amino_acid_conc           ||= initialize_key(options, :amino_acid_conc, 3)
      @sodium_chloride_intake    ||= initialize_key(options, :sodium_chloride_intake, 3, 0)
      @sodium_chloride_conc      ||= initialize_key(options, :sodium_chloride_conc, 3, 1)
      @potassium_chloride_intake ||= initialize_key(options, :potassium_chloride_intake, 3, 0)
      @potassium_chloride_conc   ||= initialize_key(options, :potassium_chloride_conc, 3, 1)
      @magnesium_intake          ||= initialize_key(options, :magnesium_intake, 3, 0)
      @magnesium_conc            ||= initialize_key(options, :magnesium_conc, 3, 1)
      @calcium_intake            ||= initialize_key(options, :calcium_intake, 3, 0)
      @calcium_conc              ||= initialize_key(options, :calcium_conc, 3, 1)
      @administration            ||= options.has_key?(:administration) ? options.fetch(:administration) : "Peripheral Line" 
      @feed_vol = @losses = 0
      @errors   = @warnings = []
    end

    def calculate_tpn 
      calculate_volumes
      calculate_additives
      calculate_dextrose_concentration_achieved
      calculate_calories
      validate_results
    end

    private

    def calculate_volumes
      @total_fluid_intake_vol = round(total_fluid_intake * current_weight, 2)
      @tpn_vol = round(total_fluid_intake_vol - feed_vol + losses, 2)
      @fat_vol = round(fat_intake * current_weight / lipid_conc, 2)
      @hav_vol = round(tpn_vol - fat_vol, 2)
      @prepared_overfill = round(hav_vol * overfill_factor, 1)
    end

    def calculate_additives
      @amino_acid_vol = volume(amino_acid_intake, amino_acid_conc) 
      @sodium_chloride_vol = volume(sodium_chloride_intake, sodium_chloride_conc)
      @potassium_chloride_vol = volume(potassium_chloride_intake, potassium_chloride_conc)
      @calcium_vol = volume(calcium_intake, calcium_conc)
      @magnesium_vol = volume(magnesium_intake, magnesium_conc)
      @mvi = round(0.5 * current_weight, 2)
      @remaining_dextrose_vol = round(prepared_overfill - total_additives, 2)
    end

    def calculate_calories
      @fat_calories = round(fat_vol * lipid_conc * 9.0, 2)
      #@cho_calories = round(hav_vol * percent_dextrose_conc * 3.4, 2)
      @cho_calories = round(((dextrose_10 / 10) + (dextrose_50 / 2)) * 3.4, 2) 

      tempAminoAcid = amino_acid_vol / overfill_factor
      @cnr_rate = round((fat_calories + cho_calories) / ((tempAminoAcid * amino_acid_conc ) /  6.25), 2)
      @calories = round(fat_calories + cho_calories + (tempAminoAcid * amino_acid_conc * 4.0), 2)
      @non_protein = round(calories - (tempAminoAcid * amino_acid_conc * 4.0), 2)
      @total_protein= round(amino_acid_intake * current_weight, 2)

      @dir_rate = round(((hav_vol * percent_dextrose_conc) / (24 * 60 * current_weight)) * 1000, 1)
    end

    def calculate_dextrose_concentration_achieved 
      remain_volume = remaining_dextrose_vol 
      overfill = prepared_overfill 
      dextrose_concentration = percent_dextrose_conc 
      wanted_dextrose_vol = overfill 
      achieved_dextrose_concentration = 0.0
      old_val = 1.0
      old_dex_50 = @dextrose_50 = 1.0
      @water = 0.0

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
            @errors << "1041" 
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
      @achieved_dextrose_conc = round(old_val * 100, 1)
      @dextrose_50 = round(@dextrose_50, 1)
      @dextrose_10 = round(@dextrose_10, 1)
      @water = round(@water, 2)
      @remaining_dextrose_vol = round(@remaining_dextrose_vol, 2)
    end

    def validate_results
      @errors   << "1017" if @amino_acid_vol.nil?
      @warnings << "1037" if @cnr_rate.nil? || @cnr_rate <= MIN_CNR 
      @warnings << "1040" if @dir_rate.nil? || @dir_rate > MAX_DIR 
      
      self.instance_variables.each do |variable|
        val = self.instance_variable_get(variable)
        variable = variable.to_s.gsub('@', '').to_sym
        @errors << KimayaCore::ERROR_CODES[variable] if (val.is_a?(Fixnum) || val.is_a?(Float))&& val < 0
      end
      
      @errors.empty? || @warnings.empty?
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
