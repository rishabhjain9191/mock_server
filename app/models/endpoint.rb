class Endpoint < ApplicationRecord
  validates :verb, inclusion: { in: %W(GET POST PATCH DELETE)}
  serialize :headers, JSON
end
