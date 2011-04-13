module Kimaya
  class TPNValidator < ActiveModel::Validator
    def validate(record)
      record.errors[:day_of_tpn] << t('errors.1001.message') if record.day_of_tpn.blank?
    end
  end
end
