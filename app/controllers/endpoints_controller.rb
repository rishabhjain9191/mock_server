class EndpointsController < ApplicationController
  before_action :validate_params, only: :update
  def index
    @endpoints = Endpoint.all
    render json: serialized_endpoint(@endpoints.to_a)
  end

  def create
    @endpoint = Endpoint.new(endpoint_params)
    if @endpoint.save
      render json: serialized_endpoint(@endpoint), status: :created, location: complete_endpoint_path
    else
      render json: @endpoint.errors, status: :unprocessable_entity
    end
  end

  def update
    @endpoint = Endpoint.find(params[:id])
    if @endpoint && @endpoint.update(endpoint_params)
      render json: serialized_endpoint(@endpoint), status: :ok, location: complete_endpoint_path
    else
      render json: @endpoint.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @endpoint = Endpoint.find_by_id(params[:id])
    if @endpoint
      @endpoint.destroy
      render json: { message: 'Endpoint deleted' }, status: :ok
    else
      render json: { error: 'no endpoint found' }, status: :not_found
    end
  end

  protected

  def serialized_endpoint(endpoints)
    data = if endpoints.is_a?(Array)
             endpoints.map do |endpoint|
               endpoint_hash endpoint
             end
           else
             endpoint_hash endpoints
           end
    { data: data }
  end

  # convert endpoint record to JSON:API format
  # For example: { data: { id, attributes: {}}}
  def endpoint_hash(endpoint)
    JSONAPI::ResourceSerializer.new(EndpointResource).object_hash(EndpointResource.new(endpoint, nil), nil)
  end

  # Extract out the params from JSON:API format. TODO: Automate this process with resources
  def endpoint_params
    endpoint_data = params.require(:data).require(:attributes).permit(:verb, :path,
                                                                      { response: [:code, :body, { headers: {} }] })
    { path: endpoint_data[:path], verb: endpoint_data[:verb], response_code: endpoint_data[:response][:code],
      body: endpoint_data[:response][:body], headers: endpoint_data[:response][:headers] }
  end

  # TODO: Check out the way to de-duplicate this logic with the model
  # one extra level of validation at controller level
  def validate_params
    data = endpoint_params
    errors = []
    errors << 'Invalid verb' if %w[GET POST PATCH DELETE].exclude?(data[:verb])
    # check for valid url
    begin
      URI.parse data[:path]
    rescue URI::InvalidURIError => e
      errors << 'Invalid Path'
    end
    render json: { errors: errors }, status: :unprocessable_entity if errors.present?
  end

  private

  def complete_endpoint_path
    request.protocol + request.host + ':' + request.port.to_s + @endpoint.path
  end
end
