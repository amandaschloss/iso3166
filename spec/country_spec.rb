# encoding: UTF-8
require "spec_helper"

describe ISO3166::Country do
  subject { ISO3166::Country.new("XX", "A COUNTRY", "UN PAYS") }

  it { should respond_to(:alpha2) }
  it { should respond_to(:english_short_name) }
  it { should respond_to(:french_short_name) }

  it { should respond_to(:id) }
  it { should respond_to(:code) }
  it { should respond_to(:name) }

  describe "#initialize" do
    subject { ISO3166::Country.new("RS", "SERBIA", "SERBIE") }

    it "sets alpha2 from the first argument" do
      subject.alpha2.should == "RS"
    end

    it "sets english_short_name from the second argument" do
      subject.english_short_name.should == "SERBIA"
    end

    it "sets french_short_name from the second argument" do
      subject.french_short_name.should == "SERBIE"
    end
  end

  describe "#==" do
    it "returns false when alpha2 does not match" do
      ISO3166::Country.new("XX", "COUNTRY", "PAYS").should_not == ISO3166::Country.new("ZZ", "COUNTRY", "PAYS")
    end

    it "returns false when english_short_name does not match" do
      ISO3166::Country.new("XX", "COUNTRY1", "PAYS").should_not == ISO3166::Country.new("XX", "COUNTRY2", "PAYS")
    end

    it "returns false when french_short_name does not match" do
      ISO3166::Country.new("XX", "COUNTRY", "PAYS1").should_not == ISO3166::Country.new("XX", "COUNTRY", "PAYS2")
    end
  end

  describe "::all" do
    subject { ISO3166::Country.all }

    it "returns an array" do
      subject.should be_instance_of(Array)
    end

    it "has country objects as elements of the array" do
      subject.should_not be_empty, "This test makes no sense if the array is empty"
      subject.each { |element| element.should be_instance_of(ISO3166::Country) }
    end

    it "includes alpha2 for countries" do
      subject.first.alpha2.should_not be_empty
    end

    it "includes english_short_name for countries" do
      subject.first.english_short_name.should_not be_empty
    end

    it "includes french_short_name for countries" do
      subject.first.french_short_name.should_not be_empty
    end

    it "parses the data files only once" do
      any_instance_of(ISO3166::Parser) do |parser|
        do_not_allow(parser).parse
      end

      ISO3166::Country.all
    end

    it "combines the data from the English and French files" do
      rs = subject.detect { |country| "RS" == country.alpha2 }
      rs.english_short_name.should == "SERBIA"
      rs.french_short_name.should == "SERBIE"
    end
  end

  describe "#id" do
    it "returns the same value as alpha2" do
      subject.id.should == subject.alpha2
    end
  end

  describe "#code" do
    it "returns the same value as alpha2" do
      subject.code.should == subject.alpha2
    end
  end

  describe "#name" do
    it "returns the same value as english_short_name" do
      subject.name.should == subject.english_short_name
    end

    context "when ISO3166.default_language is :french" do
      before(:each) { ISO3166.default_language = :french }

      it "returns the same value as french_short_name" do
        subject.name.should == subject.french_short_name
      end
    end
  end
end
