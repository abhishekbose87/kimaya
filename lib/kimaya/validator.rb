module Kimaya
  class TPNValidator < ActiveModel::Validator
    def validate(record)
      record.errors[:day_of_tpn] << :day_of_tpn if record.day_of_tpn.blank?
    end
  end
end
