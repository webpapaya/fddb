require "fddb/version"
require 'net/http'


module FDDB
  class API
    def initialize api_key, lang = 'de'
      @api_key = api_key
      @lang = lang
      @base_url = 'http://fddb.info/api/v8/'
    end

    def get_item (query)
      make_http_request :item, query
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

      uri =  URI("#{@base_url}/item/id_#{query}.xml") if type == :item
      uri =  URI("#{@base_url}/item/id_#{query}.xml") if type == :item
      uri.query = URI.encode_www_form params
      Net::HTTP.get uri
    end
  end
end
