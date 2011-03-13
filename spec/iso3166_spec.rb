# encoding: UTF-8
require "spec_helper"

describe ISO3166 do
  subject { ISO3166 }

  it { should respond_to(:default_language) }
  it { should respond_to(:default_language=) }

  it "autoloads Country" do
    expect { ISO3166::Country }.not_to raise_error
  end

  it "autoloads Parser" do
    expect { ISO3166::Parser }.not_to raise_error
  end

  describe "#default_language=" do
    it "sets the default language to its argument" do
      subject.default_language = :french

      subject.default_language.should == :french
    end
  end
end
