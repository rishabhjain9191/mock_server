class EndpointsController < ApplicationController
  def index
    @endpoints = Endpoint.all
    render json: serialized_endpoint(@endpoints)
  end

  def create
    @endpoint = Endpoint.new(endpoint_params)
    if @endpoint.save
      render json: serialized_endpoint(@endpoint), status: :created, location: complete_endpoint_path
    else
      render json: { message: 'Work in progress'}, status: 200
    end
  end
  
  def update
    @endpoint = Endpoint.find(params[:id])
    if @endpoint
      @endpoint.update(endpoint_params)
      render json: { message: "Endpoint updated successfully"}, status: 200
    else
      render json: { error: 'Unable to update user.' }, status: 400
    end
  end

  def destroy
    @endpoint = Endpoint.find_by_id(params[:id])
    if @endpoint
      @endpoint.destroy
      render json: { message: 'Endpoint deleted' }, status: 200
    else
      render json: { error: 'no endpoint found'}, status: 404
    end
  end

  protected

  def serialized_endpoint endpoints
    if endpoints.many?
      data = endpoints.map do |endpoint|
        endpoint_hash endpoint
      end
    else
      data = endpoint_hash endpoints
    end
    { :data => data }
  end

  def endpoint_hash endpoint
    JSONAPI::ResourceSerializer.new(EndpointResource).object_hash(EndpointResource.new(endpoint, nil), nil)
  end

  def endpoint_params
  endpoint_data = params.require(:data).require(:attributes).permit(:verb, :path, { response: [:code, :body, :headers => {} ]})
  {path: endpoint_data[:path], verb: endpoint_data[:verb], response_code: endpoint_data[:response][:code], body: endpoint_data[:response][:body], headers: endpoint_data[:response][:headers]
    }    
  end

  private
  
  def complete_endpoint_path
    request.protocol + request.host + ":" + request.port.to_s + @endpoint.path
  end
end
