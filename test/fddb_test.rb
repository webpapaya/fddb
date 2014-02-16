require_relative 'helper'

class FDDB_TEST < MiniTest::Test
  def setup
    @fddb = FDDB::API.new "U9H3TXH05S933NMQFMJIL64C"
    @id   = 164667
  end

  def test_implementation_get_item
    assert (@fddb.get_item @id).class == String
  end

  def test_http_request
    assert @fddb.send(:make_http_request, :item, @id).class == String
    assert @fddb.send(:make_http_request, :item, @id, 'apikey' => 1, 'lang' => 'en').class == String
    assert @fddb.send(:make_http_request, :item, @id, 'apikey' => 1) =~ /API Key invalid or not given./
  end
end