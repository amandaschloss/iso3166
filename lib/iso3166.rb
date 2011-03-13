# encoding: UTF-8
module ISO3166
  class ParseError < RuntimeError; end;

  autoload :Country, "iso3166/country"
  autoload :Parser, "iso3166/parser"

  def self.default_language
    @default_language
  end

  def self.default_language=(language_name)
    @default_language = language_name
  end
end
