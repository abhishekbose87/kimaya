module Kimaya
  class TPNValidator < ActiveModel::Validator
    def validate(record)
      record.errors[:base] << "This record is invalid"
    end
  end
end
