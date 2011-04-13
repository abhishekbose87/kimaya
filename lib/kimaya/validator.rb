module Kimaya
  class TPNValidator < ActiveModel::Validator
    REQUIRED_FIELDS = %w{day_of_tpn current_weight percent_dextrose_conc total_fluid_intake fat_intake lipid_conc overfill_factor 
    amino_acid_intake amino_acid_conc administration}
    def validate(record)
      REQUIRED_FIELDS.each do |field|
        record.errors["#{field}"] << "can't be blank" if eval("record.#{field}.blank?")
      end
    end
  end
end
