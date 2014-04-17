module Kimaya
  class TPNCalc
    include KimayaCore

    MAX_DIR = 12.0
    MIN_CNR = 150.0

    CONCENTRATIONS = {dextrose_5: 20, dextrose_10: 10, dextrose_25: 4, dextrose_50: 2}

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
      @expected_dir              ||= initialize_key(options, :expected_dir, 1, 0.0)
      @other_infusions          ||= initialize_key(options, :other_infusions, 2, 0.0)
      @administration            ||= options.has_key?(:administration) ? options.fetch(:administration) : "Peripheral Line" 
      @available_dextrose_concentrations ||= options.has_key?(:available_dextrose_concentrations) ? options.fetch(:available_dextrose_concentrations) : [:dextrose_50, :dextrose_10]
      @feed_vol = 0
      @losses   = 0
      @errors   = []
      @warnings = []
      @dextrose_concentrations = {}
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
      @other_infusions = round(other_infusions * 24, 2)
      @total_fluid_intake_vol = round(total_fluid_intake * current_weight, 2)
      @tpn_vol = round(total_fluid_intake_vol - feed_vol + losses, 2)
      @fat_vol = round(fat_intake * current_weight / lipid_conc, 2)
      @hav_vol = round(tpn_vol - fat_vol - other_infusions, 2)
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
      tmp_calories = (@dextrose_concentrations[@available_dextrose_concentrations[0]] / CONCENTRATIONS[@available_dextrose_concentrations[0]]) + (@dextrose_concentrations[@available_dextrose_concentrations[1]] / CONCENTRATIONS[@available_dextrose_concentrations[1]])
      @cho_calories = round(tmp_calories * 3.4, 2) 

      tempAminoAcid = amino_acid_vol / overfill_factor
      @cnr_rate = round((fat_calories + cho_calories) / ((tempAminoAcid * amino_acid_conc ) /  6.25), 2)
      @calories = round(fat_calories + cho_calories + (tempAminoAcid * amino_acid_conc * 4.0), 2)
      @non_protein = round(calories - (tempAminoAcid * amino_acid_conc * 4.0), 2)
      @total_protein= round(amino_acid_intake * current_weight, 2)
    end

    def calculate_dextrose_concentration_achieved
      calculate_percent_dextrose_conc

      remain_volume = remaining_dextrose_vol 
      overfill = prepared_overfill 
      dextrose_concentration = @percent_dextrose_conc 
      wanted_dextrose_vol = overfill 
      achieved_dextrose_concentration = 0.0
      old_val = 1.0
      old_dextrose_1 = dextrose_1 = 1.0
      @available_dextrose_concentrations = [:dextrose_25, :dextrose_5] if dextrose_concentration < 0.1 && !@available_dextrose_concentrations.include?(:dextrose_5)

      dextrose_conc_1, dextrose_conc_2 = @available_dextrose_concentrations

      while achieved_dextrose_concentration < dextrose_concentration do
        old_val = achieved_dextrose_concentration
        old_dextrose_1 = dextrose_1
        dextrose_2   = remain_volume - dextrose_1
        #@errors << "1041" if dextrose_10 < 0 
        dextrose_1 = dextrose_1 / CONCENTRATIONS[dextrose_conc_1]
        dextrose_2 = dextrose_2 / CONCENTRATIONS[dextrose_conc_2]
        achieved_dextrose_concentration = (dextrose_1 + dextrose_2) / overfill
        dextrose_1 = old_dextrose_1 + 1
      end
      @dextrose_concentrations[dextrose_conc_1] = round(old_dextrose_1, 1)
      @dextrose_concentrations[dextrose_conc_2] = round(remain_volume - @dextrose_concentrations[dextrose_conc_1], 1)
      @achieved_dextrose_conc = round(old_val * 100, 1)
      @remaining_dextrose_vol = round(@remaining_dextrose_vol, 2)
    end

    def validate_results
      @errors   << "1017" if @amino_acid_vol.nil?
      @warnings << "1037" if @cnr_rate.nil? || @cnr_rate <= MIN_CNR
      @warnings << "1040" if @dir_rate.nil? || @dir_rate > MAX_DIR 
      @errors   << "1505" if @achieved_dextrose_conc == 0.0

      self.instance_variables.each do |variable|
        val = self.instance_variable_get(variable)
        variable = variable.to_s.gsub('@', '').to_sym
        @errors << KimayaCore::ERROR_CODES[variable] if (val.is_a?(Fixnum) || val.is_a?(Float)) && val < 0
      end

      @errors.uniq!
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

    def calculate_percent_dextrose_conc
      @dir_rate = round(((hav_vol * @percent_dextrose_conc) / (24 * 60 * current_weight)) * 1000, 1)

      if @expected_dir > 0.0 
        if @dir_rate < @expected_dir
          # if dir_rate is less than expected dir then increase percent_dextrose_conc
          recalculate_dir(@percent_dextrose_conc, :+, 0.001)
        elsif @dir_rate > @expected_dir
          # if dir_rate is more than expected dir then decrease percent_dextrose_conc
          recalculate_dir(@percent_dextrose_conc, :-, 0.001)
        end
      end
    end

    def recalculate_dir(percent_dextrose_conc, operator, value)
      return if @dir_rate == @expected_dir
      @percent_dextrose_conc = round([percent_dextrose_conc, value].reduce(operator),4)
      @dir_rate = round(((hav_vol * @percent_dextrose_conc) / (24 * 60 * current_weight)) * 1000, 1)
      recalculate_dir(@percent_dextrose_conc, operator, value)
    end
  end
end
