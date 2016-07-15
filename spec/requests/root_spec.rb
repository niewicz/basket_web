require "web_helper"

RSpec.describe "GET /", type: :request do
  before do
    get "/"
  end

  it "returns vaild html Content-Type" do
    expect(last_response.headers["Content-Type"]).to include("text/html")
  end

  it "returns 200 HTTP code" do
    expect(last_response.status).to eql(200)
  end

  it "return list of products" do
    expect(last_response.body).to match(Regexp.new("<ul.*>(.*<li.*>.*<\/li>.*)*<\/ul>", Regexp::MULTILINE))
  end
end
