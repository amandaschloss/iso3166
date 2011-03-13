# encoding: UTF-8
require "spec_helper"

describe ISO3166 do
  it "autoloads Country" do
    expect { ISO3166::Country }.not_to raise_error
  end

  it "autoloads Parser" do
    expect { ISO3166::Parser }.not_to raise_error
  end
end
