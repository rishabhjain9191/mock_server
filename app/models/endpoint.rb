class Endpoint < ApplicationRecord
  serialize :headers, JSON
end
