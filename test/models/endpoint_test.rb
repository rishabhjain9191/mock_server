require 'test_helper'

class EndpointTest < ActiveSupport::TestCase
  test 'should save endpoint data' do
    endpoint = Endpoint.new(verb: 'GET', path: '/aba/ff')
    assert endpoint.save
  end

  test 'should serialize headers' do
    endpoint = Endpoint.new(verb: 'GET', path: '/aba/ff',
                            headers: { header_key_1: 'header_value_1', header_key_2: 'header_value_2' })
    assert endpoint.save
    assert_equal(endpoint.headers, { 'header_key_1' => 'header_value_1', 'header_key_2' => 'header_value_2' })
  end

  test 'should not save endpoint with invalid verb' do
    endpoint = Endpoint.new(verb: 'GETA', path: '/aba/ff')
    assert_not endpoint.save
  end

  test 'should not save endpoint with empty path' do
    endpoint = Endpoint.new(verb: 'GET', path: '')
    assert_not endpoint.save
  end
end
