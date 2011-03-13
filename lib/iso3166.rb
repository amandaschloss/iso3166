# encoding: UTF-8
module ISO3166
  class ParseError < RuntimeError; end;

  autoload :Country, "iso3166/country"
  autoload :Parser, "iso3166/parser"
end
