require "bundler/setup"
require "sinatra"

Dir["./lib/**/*.rb"].each { |file| require file }

module Shop
  PORTFOLIO = [
    Product.new("Harry Potter and the Order of the Pheonix", 34.50, 8, "J. K. Rowling", "Harry_Potter_and_the_Order_of_the_Phoenix.jpg"),
    Product.new("Harry Potter and the Half-Blood Prince", 29.20, 8, "J. K. Rowling", "Harry_Potter_and_the_Half-Blood_Prince.jpg"),
    Product.new("Harry Potter and the Philosopher's Stone", 23.40, 8, "J. K. Rowling", "Harry_Potter_and_the_Philosopher's_Stone_Book_Cover.jpg"),
    Product.new("The Girl on the Train", 39.90, 8, "Paula Hawkins", "the_girl_on_the_train.jpg"),
    Product.new("Gone Girl", 19.40, 8, "Gillian Flynn", "gone_girl.jpg"),
    Product.new("The C Programming Language", 74.12, 8, "Brian W. Kernighan, Dennis M. Ritchie", "c_programming_book.png"),
    Product.new("Under the Dome", 29.40, 8, "Stephen King", "under_the_dome.jpg")
  ]

  WAREHOUSE = [
    StorageItem.new(1, 10),
    StorageItem.new(2, 1),
    StorageItem.new(3, 2),
    StorageItem.new(4, 100),
    StorageItem.new(5, 5)
  ]

  BASKET = []

  class App < Sinatra::Base
    get "/" do
      portfolio = FetchPortfolio.new.call
      erb :"products/index", locals:
        { portfolio: portfolio, title: "Our products" }
    end

    get "/products/:id" do |id|
      product = FetchProduct.new.call(id)
      if product
        warehouse_item = FetchWarehouseItem.new.call(id)
        erb :"products/show", locals:
          { product: product, quantity: (warehouse_item ? warehouse_item.quantity : 0) }
      else
        status 404
        erb :"page_not_found"
      end
    end

    get "/basket" do
      if FetchBasket.new.call.empty?
        erb :"basket/empty"
      else
        basket_summary = FetchBasketSummary.new.call
        erb :"basket/show", locals:
          { basket_summary: basket_summary }
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

    post "/basket/delete_all" do
      DeleteAllBasketItem.new.call
      redirect "/basket"
    end

    post "/basket/add" do
      begin
        AddBasketItem.new(params).call
        redirect "/basket"
      rescue KeyError
        halt 422
      end
    end
  end
end
