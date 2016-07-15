require_relative "../../../lib/services/add_basket_item"
require_relative "../../../lib/services/delete_basket_item"
require "web_helper"

RSpec.describe "GET /basket", type: :request do
  context "#empty basket" do
    before do
      post "/basket/delete_all"
      get "/basket"
    end

    it "returns vaild html Content-Type" do
      expect(last_response.headers["Content-Type"]).to include("text/html")
    end

    it "returns 200 HTTP code" do
      expect(last_response.status).to eql(200)
    end

    it "returns 'empty basket' message" do
      expect(last_response.body).to include("basket is empty")
    end
  end

  context "#filled basket" do
    before(:each) do
      Shop::AddBasketItem.new({ "product_id" => "1", "quantity" => "2" }).call
      get "/basket"
    end

    it "returns vaild html Content-Type" do
      expect(last_response.headers["Content-Type"]).to include("text/html")
    end

    it "returns 200 HTTP code" do
      expect(last_response.status).to eql(200)
    end

    it "returns table of products in basket" do
      expect(last_response.body).to match(Regexp.new("<table.*>.*<\/table>", Regexp::MULTILINE))
    end

    after(:each) do
      Shop::DeleteBasketItem.new({ "product_id" => "1", "quantity" => "2" }).call
    end
  end
end
