module Kimaya
  class TPNValidator < ActiveModel::Validator
    def validate(record)
      record.errors[:day_of_tpn] << :1001 if record.day_of_tpn.blank?
    end
  end
end
