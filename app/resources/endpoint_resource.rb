class EndpointResource < JSONAPI::Resource
  attributes :verb, :path, :response_code, :body
end
