# encoding: UTF-8
module ISO3166
  class Country
    attr_reader :alpha2, :english_short_name, :french_short_name

    alias_method :id, :alpha2
    alias_method :code, :alpha2

    def self.all
      @english_data ||= Parser.new.parse File.new(File.join(File.dirname(__FILE__), "list-en1-semic-3.txt"))
      @french_data ||= Parser.new.parse File.new(File.join(File.dirname(__FILE__), "list-fr1-semic.txt"))
      @english_data.map do |english_country_data|
        french_country_data = @french_data.detect { |country| country[:alpha2] == english_country_data[:alpha2] }
        Country.new(english_country_data[:alpha2], english_country_data[:short_name], french_country_data[:short_name])
      end
    end

    def initialize(alpha2, english_short_name, french_short_name)
      @alpha2 = alpha2
      @english_short_name = english_short_name
      @french_short_name = french_short_name
    end

    def ==(other)
      alpha2 == other.alpha2 &&
      english_short_name == other.english_short_name &&
      french_short_name == other.french_short_name
    end

    def name
      :french == ISO3166.default_language ? french_short_name : english_short_name
    end
  end
end
