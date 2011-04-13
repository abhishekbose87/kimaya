module Kimaya
  class TPNValidator < ActiveModel::Validator
    def validate(record)
      options[:my_custom_key] # => "my custom value"
    end
  end
end
