class EndpointsController < ApplicationController
  def index
    @endpoints = Endpoint.all
    render json: @endpoints
  end

  def create
    puts "################################"
    puts endpoint_params
    puts "################################"
    @endpoint = Endpoint.new(endpoint_params)
    if @endpoint.save
      render json: @endpoint
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

  def endpoint_params
    # puts params
    puts params.as_json
    # params.require(:data).require(:type).permit(:type, { attributes: [:verb, :path, { response: [:code, :body] }]})
  endpoint_data = params.require(:data).require(:attributes).permit(:verb, :path, { response: [:code, :body, :headers => {} ]})
  puts "***************************"
  puts endpoint_data
  puts "***************************"
  {path: endpoint_data[:path], verb: endpoint_data[:verb], response_code: endpoint_data[:response][:code], body: endpoint_data[:response][:body], headers: endpoint_data[:response][:headers]
    }    
  end
end
