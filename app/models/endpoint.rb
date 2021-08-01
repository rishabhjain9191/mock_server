class Endpoint < ApplicationRecord
  validates :path, presence: true
  validates :verb, inclusion: { in: %W(GET POST PATCH DELETE)}
  serialize :headers, JSON
end
