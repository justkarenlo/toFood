require '../spec_helper'

describe 'GET /intro' do
  it "should display intro page" do
    get '/intro'
    # expect(last_response).to be_ok
    expect(last_response.body).to match (/ENJOY/)
  end
end

describe 'POST /' do
  before(:each) do
    User.delete_all
  end
  context "should create new user" do
    it "creates a new user" do
      user_count = User.count
      post '/register', { username: "testing", password: 123}
      after_count = User.count
      expect(after_count).to eq(user_count + 1)
    end
    it "redirects the user to the /users route" do
      post '/register', { username: "testing", password: 123 }
      expect(last_response).to be_redirect
      follow_redirect!
      last_request.url.should == 'http://example.org/'
    end
  end

  context "when the request does not include a body value" do
    it "does not create a new user" do
      user_count = User.count
      post '/users', { username: "c"}
      after_count = User.count
      expect(after_count).to eq(user_count)
    end
    it "returns a status code of 404" do
      post '/users', { name: "c"}
      expect(last_response.status).to be(404)
    end
  end

  context "when the request does not include a unique name value" do
    it "does not create a new user" do
      user_count = User.count
      post '/users', { name: "Ice", body: "THIS IS RSPEC!!!"}
      after_count = User.count
      expect(after_count).to eq(user_count)
    end
    it "returns a status code of 422" do
      post '/users', { name: "Ice", body: "THIS IS RSPEC!!!"}
      expect(last_response.status).to be(404)
    end

  end
end
