class EndpointsController < ApplicationController
  def index
    @endpoints = Endpoint.all
    JSONAPI::ResourceSerializer.new(EndpointResource).serialize_resource_set_to_hash_plural(EndpointResource.new(@endpoints, nil))
    render json: @endpoints
  end

  def create
    endpoint_data = endpoint_params
    puts endpoint_data
    @endpoint = Endpoint.new(path: endpoint_data[:path], verb: endpoint_data[:verb], response_code: endpoint_data[:response][:code], body: endpoint_data[:response][:body])
    if @endpoint.save
      render json: @endpoint
    else
      render json: { message: 'Work in progress'}, status: 200
    end
  end

  protected

  def endpoint_params
    # puts params
    puts params.as_json
    # params.require(:data).require(:type).permit(:type, { attributes: [:verb, :path, { response: [:code, :body] }]})
    params.require(:data).require(:attributes).permit(:verb, :path, { response: [:code, :body]})

  end
end
