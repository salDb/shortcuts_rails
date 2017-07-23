require 'rails_helper'

describe AppsController do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:app) {FactoryGirl.create(:app, user_id: user.id, app_type: 'shortcuts')}

  before do
    request.headers['Accept'] = 'application/json'
    request.headers['Content-Type'] = 'application/json'
    request.headers['AUTHORIZATION'] = SessionsHelper::Auth.issue({user: user.id})
  end

  it 'should get index' do
    get :index, params: { app_type: 'shortcuts' }
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(
                                 [{
                                      name: 'App',
                                      image_url: include('test.png')
                                  }])
  end

  it 'should create app' do
    app_params = { name: 'Example App',
                   app_type: 'commands',
                   image: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'shortcuts.png'), 'image/png')}
    post :create, params: app_params
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(message: 'Successfully created new app')
    expect(response.body).to include_json(app:
                                              {
                                                  name: 'Example App',
                                                  app_type: 'commands',
                                                  image_file_name: 'shortcuts.png'
                                              })
  end

  it 'should show app' do
    get :show, params: {id: app.id}
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(
                                 {
                                     name: 'App',
                                     image_url: include('test.png')
                                 })
  end

  it 'should update app' do
    app_params = { id: app.id, name: 'Updated App',
                   image: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'updated.png'), 'image/png')}
    put :update, params: app_params
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(message: 'Successfully updated app')
    expect(response.body).to include_json(app:
                                              {
                                                  name: 'Updated App',
                                                  image_url: include('updated.png')
                                              })
  end

  it 'should destroy app' do
    app_params = { id: app.id }
    delete :destroy, params: app_params
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(message: 'Successfully deleted app')
  end
end