module Validators
  class UriValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      URI.parse value
    rescue URI::InvalidURIError => e
      record.errors.add attribute, 'not a valid uri'
    end
  end
end
