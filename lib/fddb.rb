require "fddb/version"
require 'net/http'
require 'rexml/document'
require 'nori'

require_relative 'fddb/item'
require_relative 'fddb/items'

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
end
