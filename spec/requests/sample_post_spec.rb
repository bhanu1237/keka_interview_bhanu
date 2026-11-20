require "rails_helper"

# windows couldn't find rspec, didn't wanna add this to the path.
# bundle exec ruby C:\Users\giris\.local\share\gem\ruby\4.0.0\gems\rspec-core-3.13.7\exe\rspec .\spec\requests\sample_post_spec.rb

RSpec.describe "Sample POST API", type: :request do
  describe "POST /sample_post" do
    it "returns HTTP 200 OK" do
      post "/sample_post", params: {
        'param1': 1,
        'param2': 2
      }, as: json

      expect(response).to have_http_status(:ok)
      expect(response.body).to be_empty
    end
  end
end
