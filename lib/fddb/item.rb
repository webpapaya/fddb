require_relative 'parser'

module FDDB
  class Item
    include FDDB::Parser

    def initialize (xml_string)
      @item = (parse xml_string)['result']['item'] if xml_string.class == String
      @item = xml_string if xml_string.class == Hash
    end

    # returns the ingredients to an given element
    # available filters are (:minerals, :vitamines, :general)
    def get_ingredients (query = nil)
      return @item['data'] if query.nil?

      case query
        when :minerals
          search_ingredient 'm'
        when :vitamins
          search_ingredient 'v'
        when :general
          search_ingredient '(?!(a|l)).'
        else
          nil
      end
    end

    private
    def search_ingredient (search)
      get_ingredients.select {| key, value | key.to_s.match(/^#{search}/)}
    end
  end
end