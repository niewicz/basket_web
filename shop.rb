require "bundler/setup"
require "sinatra"

Dir["./lib/**/*.rb"].each { |file| require file }

module Shop

  PORTFOLIO = [
    Product.new("Book", 34.50, 0.08),
    Product.new("Ball", 8.20, 0.23),
    Product.new("Table", 180.40, 0.23)
  ]

  WAREHOUSE = []

  BASKET =[]

  class App < Sinatra::Base
    get "/" do
      CreateWarehouseItem.new.call(1, 10)
      CreateWarehouseItem.new.call(2, 15)
      CreateWarehouseItem.new.call(3, 5)
      portfolio = FetchPortfolio.new.call
      erb :"products/index", locals: {portfolio: portfolio, title: "Our products"}
    end

    get "/products/:id" do |id|
      product = FetchProduct.new.call(id)
      warehouse_item = FetchWarehouseItem.new.call(id)
      erb :"products/show", locals: {product: product, quantity: warehouse_item.quantity}
    end

    get "/basket" do
      basket_summary = FetchBasketSummary.new.call
      p basket_summary
      erb :"basket/show", locals: {basket_summary: basket_summary}
    end

    post "/basket" do
      CreateBasketItem.new(params).call
      redirect "/"
    end
  end

end