require 'rails_helper'

describe ShortcutsController do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:app) {FactoryGirl.create(:app, user_id: user.id, app_type: 'shortcuts')}
  let!(:shortcut) {FactoryGirl.create(:shortcut, app_id: app.id)}

  before do
    request.headers['Accept'] = 'application/json'
    request.headers['Content-Type'] = 'application/json'
    request.headers['AUTHORIZATION'] = SessionsHelper::Auth.issue({user: user.id})
  end

  it 'should get index' do
    get :index, params: { app_id: app.id }
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(
                                 [{
                                      action_name: 'saves a file',
                                      first_action: 'CTRL',
                                      second_action: 'S',
                                      third_action: nil,
                                      fourth_action: nil,
                                  }])
  end

  it 'should create shortcut' do
    shortcut_params = { app_id: app.id, action_name: 'some action', first_action: 'shift', second_action: 'w' }
    post :create, params: shortcut_params
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(message: 'Successfully created shortcut')
    expect(response.body).to include_json(shortcut:
                                              {
                                                  action_name: 'some action',
                                                  first_action: 'SHIFT',
                                                  second_action: 'W',
                                                  third_action: nil,
                                                  fourth_action: nil,
                                              })
  end

  it 'should update shortcut' do
    shortcut_params = { app_id: app.id, id: shortcut.id, action_name: 'new action', third_action: 'a' }
    patch :update, params: shortcut_params
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(message: 'Successfully updated shortcut')
    expect(response.body).to include_json(shortcut:
                                              {
                                                  action_name: 'new action',
                                                  first_action: 'CTRL',
                                                  second_action: 'S',
                                                  third_action: 'A',
                                                  fourth_action: nil,
                                              })
  end

  it 'should destroy shortcut' do
    shortcut_params = { app_id: app.id, id: shortcut.id }
    delete :destroy, params: shortcut_params
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(message: 'Successfully deleted shortcut')
  end
end