require "test_helper"

class EndpointsControllerTest < ActionDispatch::IntegrationTest
  test "should serve the endpoint created by user" do
    endpoint = endpoints(:two)
    get endpoint.path
    assert_response endpoint.response_code
    assert_equal endpoint.body, @response.body
  end

  test "should not serve with right path and wrong verb" do
    endpoint = endpoints(:two)
    post endpoint.path
    assert_response :not_found
  end

  test "should not serve non-existing path" do
    post '/non/existing/path'
    assert_response :not_found
  end
end
