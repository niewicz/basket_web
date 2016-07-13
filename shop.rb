require "bundler/setup"
require "sinatra"

Dir["./lib/**/*.rb"].each { |file| require file }

module Shop
  PORTFOLIO = [
    Product.new("Harry Potter and the Order of the Pheonix", 34.50, 0.08),
    Product.new("English Dictionary", 18.20, 0.23),
    Product.new("Twilight", 23.40, 0.23),
    Product.new("Futu.re", 39.90, 0.23),
    Product.new("Fairytales vol.2", 19.40, 0.23)
  ]

  WAREHOUSE = [
    StorageItem.new(1, 10),
    StorageItem.new(2, 1),
    StorageItem.new(3, 2),
    StorageItem.new(4, 100),
    StorageItem.new(5, 5),
  ]

  BASKET = []

  class App < Sinatra::Base
    get "/" do
      portfolio = FetchPortfolio.new.call
      erb :"products/index", locals:
        {portfolio: portfolio, title: "Our products"}
    end

    get "/products/:id" do |id|
      product = FetchProduct.new.call(id)
      warehouse_item = FetchWarehouseItem.new.call(id)
      if warehouse_item
        erb :"products/show", locals:
          {product: product, quantity: warehouse_item.quantity}
      else
        erb :"products/errors/not_available", locals:
          {product: product}
      end
    end

    get "/basket" do
      if FetchBasket.new.call.empty?
        erb :"basket/empty"
      else
        basket_summary = FetchBasketSummary.new.call
        erb :"basket/show", locals:
          {basket_summary: basket_summary}
      end
    end

    post "/basket/delete" do
      begin
        DeleteBasketItem.new(params).call
        redirect "/basket"
      rescue KeyError
        halt 422
      end
    end

    post "/basket/create" do
      begin
        CreateBasketItem.new(params).call
        redirect "/basket"
      rescue KeyError
        halt 422
      end
    end
  end
end
