require "web_helper"

require_relative "../../../lib/services/fetch_product"
require_relative "../../../lib/model/product"

RSpec.describe "GET /products/:id", type: :request do
  context "#product exists" do
    context "#product available" do
      before(:each) do
        do_request(1)
      end

      it "returns vaild html Content-Type" do
        expect(last_response.headers["Content-Type"]).to include("text/html")
      end

      it "returns 200 HTTP code" do
        expect(last_response.status).to eql(200)
      end

      context "#returns details of product" do
        before(:all) do
          @product = Shop::FetchProduct.new.call(1)
        end

        it "returns title of the book" do
          expect(last_response.body).to include(@product.title)
        end

        it "returns author of the book" do
          expect(last_response.body).to include(@product.author)
        end

        it "returns price of the book" do
          expect(last_response.body).to include(@product.price.to_s)
        end

        it "returns vat of the book" do
          expect(last_response.body).to include((@product.vat).to_s)
        end

        it "returns valid path to the image of the book" do
          expect(last_response.body).to include("/img/#{@product.img_address}")
        end
      end

    end

    context "#product not available" do
      before do
        do_request(7)
      end

      it "returns vaild html Content-Type" do
        expect(last_response.headers["Content-Type"]).to include("text/html")
      end

      it "returns 200 HTTP code" do
        expect(last_response.status).to eql(200)
      end

      it "returns 'not available' message" do
        expect(last_response.body).to include("<h4>not available<\/h4>")
      end
    end
  end

  context "#product does not exist" do
    before do
      do_request(1000)
    end

    it "returns vaild html Content-Type" do
      expect(last_response.headers["Content-Type"]).to include("text/html")
    end

    it "returns 404 HTTP code" do
      expect(last_response.status).to eql(404)
    end

    it "returns page not found message" do
      expect(last_response.body).to include("Page Not Found")
    end
  end

  private
  def do_request(id)
    get "products/#{id}"
  end
end
