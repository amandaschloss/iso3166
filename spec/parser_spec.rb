# encoding: UTF-8
require "spec_helper"
require "stringio"

describe ISO3166::Parser do
  it { should respond_to(:parse) }

  describe "#parse" do
    it "takes an IO object as its argument" do
      expect { subject.parse(StringIO.new("Ignore\n\nCOUNTRY;XX")) }.to_not raise_error
    end

    context "with valid input" do
      let(:valid_input) do
        StringIO.new <<-END_INPUT.gsub(/^ */, "")
          This first line of the input should be ignored.
          
          AFGHANISTAN;AF
          
          
        END_INPUT
      end

      it "returns an array" do
        subject.parse(valid_input).should be_instance_of(Array)
      end

      it "has hashes objects as elements of the array it returns" do
        subject.parse(valid_input).each { |element| element.should be_instance_of(Hash) }
      end

      it "ignores the first and any empty lines in the input" do
        subject.parse(valid_input).length.should == 1
      end

      it "parses the appropriate short name" do
        subject.parse(valid_input).first[:short_name].should == "AFGHANISTAN"
      end

      it "parses the appropriate alpha-2 code" do
        subject.parse(valid_input).first[:alpha2].should == "AF"
      end
    end

    context "with input that has one line" do
      let(:invalid_input) { StringIO.new("Just one line.") }

      it "raises a ParseError" do
        expect { subject.parse(invalid_input) }.to raise_error(ISO3166::ParseError)
      end
    end

    context "with input that has two line" do
      let(:invalid_input) { StringIO.new("Just two\nlines.") }

      it "raises a ParseError" do
        expect { subject.parse(invalid_input) }.to raise_error(ISO3166::ParseError)
      end
    end

    context "with the file downloaded from ISO as input" do
      let(:input) { File.new(File.expand_path('../../lib/iso3166/list-en1-semic-3.txt', __FILE__)) }

      it "correctly handles the ISO-8859-1 encoding" do
        # ÅLAND ISLANDS contains a special character,
        # so it is a good test case that the conversion from ISO-8859-1
        # to UTF-8 happens as it should.
        aland_islands = subject.parse(input)[1]

        aland_islands[:short_name].scan(/./mu).size.should == 13
      end
    end
  end
end
