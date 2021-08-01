class MocksController < ApplicationController
  def handle
    @endpoint = Endpoint.find_by verb: request.method, path: '/' + params[:path]
    if @endpoint
      @endpoint.headers.each do |header_key, header_value|
        response[header_key] = header_value
      end
      render json: @endpoint, status: @endpoint[:response_code]
    else
      render json: { error: "Not found"}, status: 404
    end
  end
end
