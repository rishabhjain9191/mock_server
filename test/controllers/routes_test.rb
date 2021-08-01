require "test_helper"

class RoutesTest < ActionDispatch::IntegrationTest
  test "should route the user defined paths to mock controller" do
    endpoint = endpoints(:two)
    assert_recognizes({ controller: 'mocks', action: 'handle', path: endpoint.path[1,endpoint.path.length]}, endpoint.path)
  end
end
