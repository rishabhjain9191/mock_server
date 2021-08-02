module Validators
  class UriValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      begin
        URI.parse value
      rescue URI::InvalidURIError => exception
        record.errors.add attribute, "not a valid uri"
      end
    end
  end
end
