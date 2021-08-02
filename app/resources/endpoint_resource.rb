class EndpointResource < JSONAPI::Resource
  attributes :verb, :path
  attribute :response

  exclude_links [:self]

  def response
    { code: @model.response_code, body: @model.body, headers: @model.headers }
  end

  def fetchable_fields
    super
  end
end
