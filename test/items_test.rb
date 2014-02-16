require_relative 'helper'

class Items_Test < MiniTest::Test
  def setup
    @file = File.read('./sample_search.xml')
    @items = FDDB::Items.new @file
  end

  def test_get_ingredients_nil?
    refute_nil @items.get_ingredients
    refute_nil @items.get_ingredients :general
    refute_nil @items.get_ingredients :minerals
    refute_nil @items.get_ingredients :vitamins

    (@items.get_ingredients :blabla).each do |item|
      assert_nil item
    end
  end

  def test_get_ingredients_general
    result = @items.get_ingredients :general
    result.each do |item|
      assert item.has_key? ('kj')
      assert item.has_key? ('m_chlor_mg')
      assert item.has_key? ('v_e_mg')
    end
  end

  def test_item_error
    file = File.read('./sample_error.xml')
    error_item = FDDB::Item.init file
    assert_nil error_item, "error is nil"
  end
end
