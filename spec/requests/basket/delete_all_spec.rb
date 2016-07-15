require "web_helper"

RSpec.describe "POST /basket/delete_all", type: :request do
  before(:each) do
    do_request
  end

  it "redirects to /basket" do
    expect(last_response).to be_redirect
  end

  it "returns 200 HTTP code" do
    follow_redirect!
    expect(last_response.status).to eql(200)
  end

  private
  def do_request
    post "/basket/delete_all"
  end
end
