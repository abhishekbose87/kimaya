module Kimaya
  class TPNValidator < ActiveModel::Validator
    REQUIRED_FIELDS = %w{day_of_tpn current_weight percent_dextrose_conc total_fluid_intake fat_intake lipid_conc overfill_factor 
    amino_acid_intake amino_acid_conc administration}
    def validate(record)
      record.errors.add(:day_of_tpn, :day_of_tpn_blank) if record.day_of_tpn.blank? 
      REQUIRED_FIELDS.each do |field|
      end
    end
  end
end
