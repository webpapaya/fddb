require_relative 'helper'

class FDDB_TEST < MiniTest::Test
  def setup
    @fddb  = FDDB::API.new 'xxxx'
    @id    = 164667
    @query = 'banana'
  end

  def test_implementation_get_item
    assert (@fddb.get_item @id).class == FDDB::Item
    assert (@fddb.search 'banana').class == FDDB::Items
  end

  def test_http_request
    if @fddb.send(:make_http_request, :item, @id) =~ /error/
      puts "error api limit exceeded"
    else
      assert @fddb.send(:make_http_request, :item, @id).class == String
      assert @fddb.send(:make_http_request, :item, @id, 'apikey' => 1, 'lang' => 'en').class == String
      assert @fddb.send(:make_http_request, :item, @id, 'apikey' => 1) =~ /API Key invalid or not given./

      assert @fddb.send(:make_http_request, :search, '1234587654') =~ /Item not found/
      assert @fddb.send(:make_http_request, :search, 'banana',  'apikey' => 1) =~ /API Key invalid or not given./
      assert @fddb.send(:make_http_request, :search, 'banana').class == String
    end
  end
end