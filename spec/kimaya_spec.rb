$:.unshift(File.dirname(__FILE__))
require 'spec_helper'

module Kimaya

  describe TPNCalc do

    describe "Calculate with default values" do
      def build_tpn(params = {})
        @tpn = Kimaya::TPNCalc.new(params)
      end

      def match_results(results = {})
        results.keys.each do |key|
          @tpn.send(key).should eq(results[key])
        end
      end

      it  "test latest test and test" do
        build_tpn({current_weight: 1.2, percent_dextrose_conc: 0.1, total_fluid_intake: 125, fat_intake: 0.5,
                  lipid_conc: 0.1, overfill_factor: 1.2, amino_acid_intake: 0.5, amino_acid_conc: 0.05})
        @tpn.calculate_tpn
        @tpn.errors.empty?.should == true
        match_results({current_weight: 1.2, percent_dextrose_conc: 0.1, total_fluid_intake: 125, fat_intake: 0.5,
                  lipid_conc: 0.1, overfill_factor: 1.2, amino_acid_intake: 0.5, amino_acid_conc: 0.05, 
                  total_fluid_intake_vol: 150.0, tpn_vol: 150.0, fat_vol: 6.0, hav_vol: 144.0, prepared_overfill: 172.8, 
                  amino_acid_vol: 14.4, sodium_chloride_vol: 0.0, potassium_chloride_vol: 0.0, calcium_vol: 0.0, magnesium_vol: 0.0, 
                  mvi: 0.6, heparin: 0, remaining_dextrose_vol: 157.8, dextrose_50: 4.0, water: 0.0, dextrose_10: 153.8, 
                  achieved_dextrose_conc: 9.8, fat_calories: 5.4, cho_calories: 59.09, cnr_rate: 671.77, non_protein: 64.49, 
                  total_protein: 0.6, dir_rate: 8.3})
      end

      it  "test Zoting preeti santosh" do
        build_tpn({current_weight: 0.82, percent_dextrose_conc: 0.1, total_fluid_intake: 170, overfill_factor: 1.2, 
                  amino_acid_intake: 1.5, amino_acid_conc: 0.1, sodium_chloride_intake: 5, sodium_chloride_conc: 3.3,
                  potassium_chloride_intake: 2, potassium_chloride_conc: 2, calcium_intake: 2, calcium_conc: 0.45, 
                  magnesium_intake:0.3, magnesium_conc: 4, administration: "Central Line"})
        @tpn.calculate_tpn
        @tpn.errors.empty?.should == true
        match_results({current_weight: 0.82, percent_dextrose_conc: 0.1, total_fluid_intake: 170, overfill_factor: 1.2, 
                  amino_acid_intake: 1.5, amino_acid_conc: 0.1, sodium_chloride_intake: 5, sodium_chloride_conc: 3.3,
                  potassium_chloride_intake: 2, potassium_chloride_conc: 2, calcium_intake: 2, calcium_conc: 0.45, 
                  magnesium_intake:0.3, magnesium_conc: 4, administration: "Central Line",
                  total_fluid_intake_vol: 139.4, tpn_vol: 139.4, fat_vol: 0.0, hav_vol: 139.4, prepared_overfill: 167.3, 
                  amino_acid_vol: 14.76, sodium_chloride_vol: 1.49, potassium_chloride_vol: 0.98, calcium_vol: 4.37, magnesium_vol: 0.07, 
                  mvi: 0.41, heparin: 0.17, remaining_dextrose_vol: 145.05, dextrose_50: 6.0, water: 0.0, dextrose_10: 139.1, 
                  achieved_dextrose_conc: 9.9, fat_calories: 0.0, cho_calories: 57.49, cnr_rate: 292.12, non_protein: 57.49, 
                  total_protein: 1.23, dir_rate: 11.8})
      end

      it  "test Langole Sunita" do
        build_tpn({current_weight: 1.36, percent_dextrose_conc: 0.1, total_fluid_intake: 150, fat_intake: 2.0, lipid_conc: 0.2,
                  overfill_factor: 1.2, amino_acid_intake: 2.7, amino_acid_conc: 0.1, sodium_chloride_intake: 3, sodium_chloride_conc: 3.3,
                  potassium_chloride_intake: 2, potassium_chloride_conc: 2, calcium_intake: 2, calcium_conc: 0.45, 
                  magnesium_intake:0.3, magnesium_conc: 4, administration: "Central Line"})
        @tpn.calculate_tpn
        @tpn.errors.empty?.should == true
        match_results({current_weight: 1.36, percent_dextrose_conc: 0.1, total_fluid_intake: 150, fat_intake: 2.0, lipid_conc: 0.2,
                  overfill_factor: 1.2, amino_acid_intake: 2.7, amino_acid_conc: 0.1, sodium_chloride_intake: 3, sodium_chloride_conc: 3.3,
                  potassium_chloride_intake: 2, potassium_chloride_conc: 2, calcium_intake: 2, calcium_conc: 0.45, 
                  magnesium_intake:0.3, magnesium_conc: 4, administration: "Central Line",
                  total_fluid_intake_vol: 204.0, tpn_vol: 204.0, fat_vol: 13.6, hav_vol: 190.4, prepared_overfill: 228.5, 
                  amino_acid_vol: 44.06, sodium_chloride_vol: 1.48, potassium_chloride_vol: 1.63, calcium_vol: 7.25, magnesium_vol: 0.12, 
                  mvi: 0.68, heparin: 0.23, dextrose_50: 14.0, water: 0.0, dextrose_10: 159.1, 
                  achieved_dextrose_conc: 9.8, fat_calories: 24.48, cho_calories: 77.89, cnr_rate: 174.26, non_protein: 102.37, 
                  total_protein: 3.67, dir_rate: 9.7})
      end

      it  "test Bhapkar mangal" do
        build_tpn({current_weight: 1.11, percent_dextrose_conc: 0.1, total_fluid_intake: 80, 
                  overfill_factor: 1.2, amino_acid_intake: 1, amino_acid_conc: 0.1, sodium_chloride_intake: 3, sodium_chloride_conc: 3.3,
                  potassium_chloride_intake: 2, potassium_chloride_conc: 2, calcium_intake: 2, calcium_conc: 0.45, 
                  magnesium_intake: 2, magnesium_conc: 4})
        @tpn.calculate_tpn
        @tpn.errors.empty?.should == true
        match_results({current_weight: 1.11, percent_dextrose_conc: 0.1, total_fluid_intake: 80,
                  overfill_factor: 1.2, amino_acid_intake: 1, amino_acid_conc: 0.1, sodium_chloride_intake: 3, sodium_chloride_conc: 3.3,
                  potassium_chloride_intake: 2, potassium_chloride_conc: 2, calcium_intake: 2, calcium_conc: 0.45, 
                  magnesium_intake: 2, magnesium_conc: 4,
                  total_fluid_intake_vol: 88.8, tpn_vol: 88.8, hav_vol: 88.8, prepared_overfill: 106.6, 
                  amino_acid_vol: 13.32, sodium_chloride_vol: 1.21, potassium_chloride_vol: 1.33, calcium_vol: 5.92, magnesium_vol: 0.67, 
                  mvi: 0.56, dextrose_50: 6.0, water: 0.0, dextrose_10: 77.6, 
                  achieved_dextrose_conc: 9.7, fat_calories: 0, cho_calories: 36.58, cnr_rate: 205.97, non_protein: 36.58, 
                  total_protein: 1.11, dir_rate: 5.6})
      end

      it  "test Shaikh Rauf Kasif" do
        build_tpn({current_weight: 2.6, percent_dextrose_conc: 0.1, total_fluid_intake: 100, 
                  overfill_factor: 1.2, amino_acid_intake: 1.3, amino_acid_conc: 0.1, sodium_chloride_intake: 8, sodium_chloride_conc: 3.3,
                  potassium_chloride_intake: 0, potassium_chloride_conc: 2, calcium_intake: 2, calcium_conc: 0.45, 
                  magnesium_intake: 0.3, magnesium_conc: 4, administration: "Central Line"})
        @tpn.calculate_tpn
        @tpn.errors.empty?.should == true
        match_results({current_weight: 2.6, percent_dextrose_conc: 0.1, total_fluid_intake: 100,
                  overfill_factor: 1.2, amino_acid_intake: 1.3, amino_acid_conc: 0.1, sodium_chloride_intake: 8, sodium_chloride_conc: 3.3,
                  potassium_chloride_intake: 0, potassium_chloride_conc: 2, calcium_intake: 2, calcium_conc: 0.45, 
                  magnesium_intake: 0.3, magnesium_conc: 4, administration: "Central Line",
                  total_fluid_intake_vol: 260.0, tpn_vol: 260.0, hav_vol: 260.0, prepared_overfill: 312.0, 
                  amino_acid_vol: 40.56, sodium_chloride_vol: 7.56, potassium_chloride_vol: 0.0, calcium_vol: 13.87, magnesium_vol: 0.23, 
                  mvi: 1.3, dextrose_50: 16.0, water: 0.0, dextrose_10: 232.2, 
                  achieved_dextrose_conc: 9.9, fat_calories: 0, cho_calories: 106.15, cnr_rate: 196.28, non_protein: 106.15, 
                  total_protein: 3.38, dir_rate: 6.9, heparin: 0.31})
      end

      it  "test Shaikh Rauf Kasif with fat" do
        build_tpn({current_weight: 2.6, percent_dextrose_conc: 0.1, total_fluid_intake: 100, fat_intake: 1.2, 
                  overfill_factor: 1.2, amino_acid_intake: 1.3, amino_acid_conc: 0.1, sodium_chloride_intake: 8, sodium_chloride_conc: 3.3,
                  potassium_chloride_intake: 0, potassium_chloride_conc: 2, calcium_intake: 2, calcium_conc: 0.45, 
                  magnesium_intake: 0.3, magnesium_conc: 4, administration: "Central Line"})
        @tpn.calculate_tpn
        @tpn.errors.empty?.should == true
        match_results({current_weight: 2.6, percent_dextrose_conc: 0.1, total_fluid_intake: 100,
                  overfill_factor: 1.2, amino_acid_intake: 1.3, amino_acid_conc: 0.1, sodium_chloride_intake: 8, sodium_chloride_conc: 3.3,
                  potassium_chloride_intake: 0, potassium_chloride_conc: 2, calcium_intake: 2, calcium_conc: 0.45, 
                  magnesium_intake: 0.3, magnesium_conc: 4, administration: "Central Line",
                  total_fluid_intake_vol: 260.0, tpn_vol: 260.0, hav_vol: 228.8, prepared_overfill: 274.6, 
                  amino_acid_vol: 40.56, sodium_chloride_vol: 7.56, potassium_chloride_vol: 0.0, calcium_vol: 13.87, magnesium_vol: 0.23, 
                  mvi: 1.3, dextrose_50: 16.0, water: 0.0, dextrose_10: 194.8, fat_vol: 31.2,
                  achieved_dextrose_conc: 9.9, fat_calories: 28.08, cho_calories: 93.43, cnr_rate: 224.69, non_protein: 121.51, 
                  total_protein: 3.38, dir_rate: 6.1, heparin: 0.27})
      end

      it  "test CNR warning" do
        build_tpn({current_weight: 0.5, percent_dextrose_conc: 0.1, total_fluid_intake: 50,
                  overfill_factor: 1.2, amino_acid_intake: 0.9, amino_acid_conc: 0.05})
        @tpn.calculate_tpn
        @tpn.errors.empty?.should == true
        @tpn.warnings.empty?.should_not == true
        @tpn.warnings.include? "1037"
      end

      it  "test DIR warning" do
        build_tpn({current_weight: 1.2, percent_dextrose_conc: 0.1, total_fluid_intake: 180,
                  overfill_factor: 1.2, amino_acid_intake: 0.6, amino_acid_conc: 0.05})
        @tpn.calculate_tpn
        @tpn.errors.empty?.should == true
        @tpn.warnings.empty?.should_not == true
        @tpn.warnings.include? "1040"
      end
    end
  end
end
