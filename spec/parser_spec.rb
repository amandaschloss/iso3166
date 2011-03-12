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

      it "has Country objects as elements of the array it returns" do
        subject.parse(valid_input).each { |element| element.should be_instance_of(ISO3166::Country) }
      end

      it "ignores the first and any empty lines in the input" do
        subject.parse(valid_input).length.should == 1
      end

      it "creates each Country with the appropriate English short name" do
        subject.parse(valid_input).first.english_short_name.should == "AFGHANISTAN"
      end

      it "creates each Country with the appropriate alpha-2 code" do
        subject.parse(valid_input).first.alpha2.should == "AF"
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
  end
end
