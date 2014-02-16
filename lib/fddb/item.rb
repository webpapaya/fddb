require_relative 'parser'

module FDDB
  class Item
    attr_reader :item
    include FDDB::Parser

    def self.init (xml_string)
      element = Item.new xml_string
      return nil if element.item['error']
      element
    end

    def check_item (xml_string)
      return xml_string if xml_string.class == Hash # if item is already a hash

      begin
        item = parse xml_string
        throw "Error - #{item['error']}" unless item['error'].nil?

        response = item['result']['item'] if xml_string.class == String
      rescue Exception => e
        puts e
        response = item
      end
      response
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
    def initialize (xml_string)
      @item = check_item xml_string
    end

    def search_ingredient (search)
      get_ingredients.select {| key, value | key.to_s.match(/^#{search}/)}
    end
  end
end