# encoding: UTF-8
require "spec_helper"

describe ISO3166::Country do
  subject { ISO3166::Country.new("", "") }
  it { should respond_to(:alpha2) }
  it { should respond_to(:english_short_name) }

  describe "#initialize" do
    it "sets english_short_name from the first argument" do
      country = ISO3166::Country.new("SERBIA", "RS")

      country.english_short_name.should == "SERBIA"
    end

    it "sets alpha2 from the first argument" do
      country = ISO3166::Country.new("SERBIA", "RS")

      country.alpha2.should == "RS"
    end
  end

  describe "#==" do
    it "returns true when both alpha2 and english_short_name match" do
      ISO3166::Country.new("COUNTRY", "XX").should == ISO3166::Country.new("COUNTRY", "XX")
    end

    it "returns false when alpha2 does not match" do
      ISO3166::Country.new("COUNTRY", "XX").should_not == ISO3166::Country.new("COUNTRY", "ZZ")
    end

    it "returns false when english_short_name does not match" do
      ISO3166::Country.new("COUNTRY1", "XX").should_not == ISO3166::Country.new("COUNTRY2", "XX")
    end
  end

  describe "::all" do
    subject { ISO3166::Country.all }

    it "returns the value of ISO3166::Country::ALL" do
      subject.should == ISO3166::Country::ALL
    end
  end
end
