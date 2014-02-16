require "fddb/version"
require 'net/http'
require 'rexml/document'
require 'nori'

require_relative 'fddb/parser'


module FDDB
  class API
    def initialize api_key, lang = 'de', format= :json
      @api_key = api_key
      @lang = lang
      @base_url = 'http://fddb.info/api/v8'
      @format  =  format
    end

    def get_item (query)
      response = make_http_request :item, query
    end

    def search (query)
      make_http_request :search, query
    end

    private
    # makes an http_request to fddb database
    # @param type {:item or :search}
    # @param query - the query
    # @param params - additional http params
    #
    # examples:
    # make_http_request :search, 'beer', 'lang' => 'en'
    def make_http_request (type, query, *params)
      params = params.reduce(:+)
      params ||= {}
      params['apikey'] ||= @api_key
      params['lang'] ||= @lang

      if type == :item
        uri =  URI("#{@base_url}/item/id_#{query}.xml")
      elsif type == :search
        uri = uri =  URI("#{@base_url}/search/item.xml")
        params['q'] = query
      else
        throw('undefined search type')
      end

      uri.query = URI.encode_www_form params
      puts uri
      Net::HTTP.get uri
    end
  end


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
