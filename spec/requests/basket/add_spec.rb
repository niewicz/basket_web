require "web_helper"

RSpec.describe "POST /basket/add", type: :request do
  context "#invalid arguments" do
    let(:invalid_params) { { product_id: 'book' } }

    before(:each) do
      do_request(invalid_params)
    end

    it "returns 422 HTTP code" do
      expect(last_response.status).to eql(422)
    end
  end

  context "#valid arguments" do
    let(:valid_params) { { "product_id" => "1", "quantity" => "1" } }

    before(:each) do
      do_request(valid_params)
    end

    it "redirects to /basket" do
      expect(last_response).to be_redirect
    end

    it "returns 200 HTTP code" do
      follow_redirect!
      expect(last_response.status).to eql(200)
    end

    it "calls DeleteBasketItem with valid argument" do
      expect(Shop::AddBasketItem).to receive(:new).with(valid_params).and_call_original

      do_request(valid_params)
    end

    after(:each) do
      restore_previous_state(valid_params)
    end
  end

  private
  def do_request(params)
    post "/basket/add", params
  end

  def restore_previous_state(params)
    post "/basket/delete", params
  end
end
