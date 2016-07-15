require "web_helper"

RSpec.describe "LAYOUT", type: :request do
  before do
    get "/"
  end

  it "returns title" do
    expect(last_response.body).to include("<title>booking.shop<\/title>")
  end

  it "returns link to basket" do
    expect(last_response.body).to match(Regexp.new("<a.*href=\"\/basket\".*>.*<\/a>", Regexp::MULTILINE))
  end

  it "returns link to home" do
    expect(last_response.body).to match(Regexp.new("<a.*href=\"\/\".*>.*<\/a>", Regexp::MULTILINE))
  end
end
