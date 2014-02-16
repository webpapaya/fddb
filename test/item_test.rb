require_relative 'helper'


class Item_Test < MiniTest::Test
  def setup
    @file = File.read('./sample_item.xml')
    @item = FDDB::Item.new @file
  end

  def test_get_ingredients_nil?
    refute_nil @item.get_ingredients
    refute_nil @item.get_ingredients :general
    refute_nil @item.get_ingredients :minerals
    refute_nil @item.get_ingredients :vitamins
  end

  def test_get_ingredients_general
    result = @item.get_ingredients :general
    assert result.has_key? ('kj')
    assert result.has_key? ('m_chlor_mg')
    assert result.has_key? ('v_e_mg')
  end

  def test_get_ingredients
    result = @item.get_ingredients :minerals
    assert result.has_key? ('m_chlor_mg')
    refute result.has_key? ('kj')
    refute result.has_key? ('v_e_mg')
  end

  def test_get_vitamins
    result = @item.get_ingredients :vitamins
    refute result.has_key? ('m_chlor_mg')
    refute result.has_key? ('kj')
    assert result.has_key? ('v_e_mg')
  end
end
