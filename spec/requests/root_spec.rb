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

  it "returns title" do
    expect(last_response.body).to include("<title>Shop<\/title>")
  end

  it "returns link to basket" do
    expect(last_response.body).to match("<a\ href=\"\/basket\">.*BASKET.*<\/a>")
  end

  it "return list of products" do
    expect(last_response.body).to match("<ul>(\\s*<li>\\s*.*\\s*.*<\/li>\\s*)*<\/ul>")
  end
end
