class MocksController < ApplicationController
  def handle
    @endpoint = Endpoint.find_by verb: request.method, path: requested_path
    if @endpoint.present?
      @endpoint.headers.each do |header_key, header_value|
        response[header_key] = header_value
      end
      render json: @endpoint.body, status: @endpoint[:response_code]
    else
      render json: { code: 'not found', "details": 'Requested page ' + requested_path + ' does not exist' },
             status: :not_found
    end
  end

  private

  def requested_path
    '/' + params[:path]
  end
end
