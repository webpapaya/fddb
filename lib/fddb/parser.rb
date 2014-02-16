module FDDB
  module Parser
    def parse (xml_string)
      parser = Nori.new
      parser.parse(xml_string)
    end
  end
end

