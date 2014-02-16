require_relative 'helper'

class FDDB_TEST < MiniTest::Test
  def setup
    @fddb  = FDDB::API.new FDDB::APY_KEY
    @id    = 164667
    @query = 'banana'
  end

  def test_implementation_get_item
    assert (@fddb.get_item @id).class == String
    assert (@fddb.search 'banana').class == String
  end

  def test_http_request
    unless @fddb.send(:make_http_request, :item, @id) =~ /error/
      assert @fddb.send(:make_http_request, :item, @id).class == String
      assert @fddb.send(:make_http_request, :item, @id, 'apikey' => 1, 'lang' => 'en').class == String
      assert @fddb.send(:make_http_request, :item, @id, 'apikey' => 1) =~ /API Key invalid or not given./

      assert @fddb.send(:make_http_request, :search, '1234587654') =~ /Item not found/
      assert @fddb.send(:make_http_request, :search, 'banana',  'apikey' => 1) =~ /API Key invalid or not given./
      assert @fddb.send(:make_http_request, :search, 'banana').class == String
    end
  end

  def test_api_limit
    refute @fddb.send(:make_http_request, :search, 'banana') =~ /API Limit exceeded!/, "api limit exceeded"
  end
end