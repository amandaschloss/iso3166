# encoding: UTF-8
module ISO3166
  class Country
    attr_reader :alpha2, :english_short_name

    def self.all
      ALL
    end

    def initialize(english_short_name, alpha2)
      @english_short_name = english_short_name
      @alpha2 = alpha2
    end

    def ==(other)
      alpha2 == other.alpha2 && english_short_name == other.english_short_name
    end
  end
end
