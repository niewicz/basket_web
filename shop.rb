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
      erb :index
    end
  end

end

#Shop::Main.run
#Shop::CreateBasketItem.new.call(1, 20)
#Shop::CreateBasketItem.new.call(2, 3)
#Shop::CreateBasketItem.new.call(3, 1)
#p Shop::BASKET
#p "\n"
#p Shop::WAREHOUSE
#p "\n"
#Shop::DeleteBasketItem.new.call(1, 2)
#Shop::DeleteBasketItem.new.call(2, 2)
#Shop::DeleteBasketItem.new.call(3, 1)
#p "\n"
#p Shop::BASKET
#p "\n"
#p Shop::WAREHOUSE