require_relative "../model/basket_summary"

module Shop

  class FetchBasketSummary
    def call
      BasketSummary.new
    end
  end

end