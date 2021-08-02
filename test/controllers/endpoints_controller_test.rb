require 'test_helper'

class EndpointsControllerTest < ActionDispatch::IntegrationTest
  test 'should get list of all endpoints' do
    get endpoints_url
    assert_response :success
    assert @response.parsed_body['data'].length == Endpoint.count
  end

  test 'should create a new endpoint with valid params' do
    post endpoints_path,
         params: { data: { type: 'endpoints', attributes: { verb: 'GET', path: '/bonjour', response: { code: 201, body: { message: 'Bonjour' } } } } }, as: :json
    assert_response :created
    assert_not_nil Endpoint.find_by_path('/bonjour')
  end

  test 'should not save endpoint with invalid verb(GETA)' do
    post endpoints_path,
         params: { data: { type: 'endpoints', attributes: { verb: 'GETA', path: '/bye', response: { code: 201, body: { message: 'Bonjour' } } } } }, as: :json
    assert_response :unprocessable_entity
    assert_nil Endpoint.find_by_path('/bye')
  end

  test 'should update the endpoint' do
    assert_no_difference('Endpoint.count') do
      patch endpoint_path(Endpoint.last),
            params: { data: { type: 'endpoints', attributes: { verb: 'GET', path: '/new-path', response: { code: 201, body: { message: 'Hola' } } } } }, as: :json
    end
    assert_response :ok
    assert_not_nil Endpoint.find_by_path('/new-path')
  end

  test 'should delete endpoint' do
    endpoint = endpoints(:one)
    delete endpoint_url(endpoint)
    assert_raises(ActiveRecord::RecordNotFound) do
      endpoint.reload
    end
  end
end
