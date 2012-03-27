require 'spec_helper'

describe "a bug" do
  it "doesn't let me use 'visit' one level deep" do
    visit '/404.html'
  end

  describe "a second level" do
    it "lets me use 'visit' nested in another describe" do
      visit '/404.html'
    end
  end
end

