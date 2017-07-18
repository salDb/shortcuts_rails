require 'rails_helper'

describe UsersController do
  let!(:user) { FactoryGirl.create(:user) }
  before do
    request.headers['Accept'] = 'application/json'
    request.headers['Content-Type'] = 'application/json'
  end
  it 'should create user' do
    user_params = {
        username: '5oseh',
        password: '123456',
        password_confirmation: '123456'
    }
    post :create, params: user_params

    expect(response.status).to eq(200)
    expect(response.body).to include_json(message: 'Successfully created a new account')
  end

  it 'should update user' do
    request.headers['AUTHORIZATION'] = SessionsHelper::Auth.issue({user: user.id})

    user_params = { 'user': { 'username': 'new username' }}
    post :update, params: user_params
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(message: 'Successfully updated your account')
  end
end