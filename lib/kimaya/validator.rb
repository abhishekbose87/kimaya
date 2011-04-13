module Kimaya
  class TPNValidator < ActiveModel::Validator
    validates_each :day_of_tpn, :current_weight do |record, attr, value|
      record.errors.add attr, 'cant be blank' if value.blank?
    end
  end
end
