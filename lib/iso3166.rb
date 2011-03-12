# encoding: UTF-8
module ISO3166
  class ParseError < RuntimeError; end;

  autoload :Country, "iso3166/country"
  autoload :Parser, "iso3166/parser"

  Country::ALL = Parser.new.parse File.new(File.join(File.dirname(__FILE__), "iso3166", "list-en1-semic-3.txt"))
end
