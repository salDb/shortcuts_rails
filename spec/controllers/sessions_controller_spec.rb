require 'rails_helper'

describe SessionsController do
  context 'logging in' do
    let!(:user) { FactoryGirl.create(:user) }
    before do
      request.headers['Accept'] = 'application/json'
      request.headers['Content-Type'] = 'application/json'
    end
    it 'with correct credentials should return login token' do
      login_token = SessionsHelper::Auth.issue({user: user.id})
      user_params = { username: user.username, password: '123456' }
      post :create, params: user_params
      expect(response).to have_http_status(200)
      expect(response.body).to include_json(message: "Successfully logged in")
      expect(response.body).to include_json(auth_token: login_token)
    end
    it 'with incorrect credentials should not return login token' do
      user_params = { username: user.username, password: '123' }

      post :create, params: user_params
      expect(response).to have_http_status(401)
      expect(response.body).to include_json(message: 'Could not autheticate user')
    end
  end
end