include Validators

class Endpoint < ApplicationRecord
  validates :path, presence: true, uri: true
  validates :verb, inclusion: { in: %w[GET POST PATCH DELETE] }
  serialize :headers, JSON
  
  def self.fetch_latest_endpoint(verb, path)
    self.where(verb: verb, path: path).order('updated_at desc').limit(1).first
  end
end
