# encoding: UTF-8
require "spec_helper"

describe ISO3166 do
  it "sets Country::ALL to the result of parsing the included list of countries" do
    input_file = File.new(File.expand_path('../../lib/iso3166/list-en1-semic-3.txt', __FILE__))
    ISO3166::Country::ALL.should == ISO3166::Parser.new.parse(input_file)
  end
end
