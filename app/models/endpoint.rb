include Validators

class Endpoint < ApplicationRecord
  validates :path, presence: true, uri: true
  validates :verb, inclusion: { in: %w[GET POST PATCH DELETE] }
  serialize :headers, JSON
end
