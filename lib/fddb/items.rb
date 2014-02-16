require_relative 'parser'

module FDDB
  class Items
    include FDDB::Parser
    def initialize (xml_data)
      create_items((parse xml_data)['result']['item'])
    end

    def get_ingredients (query = nil)
      result = []
      @items.each do |item|
        result << (item.get_ingredients query)
      end
      result
    end

    private
    def create_items items
      @items = []
      items.each do | item |
        @items << (Item.new item)
      end
    end
  end
end
