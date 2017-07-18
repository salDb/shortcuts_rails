require 'rails_helper'

describe CommandsController do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:app) {FactoryGirl.create(:app, user_id: user.id, app_type: 'commands')}
  let!(:command) {FactoryGirl.create(:command, app_id: app.id)}

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
                                      command_description: 'start the rails production server as a background process',
                                      command: 'rails s -e production -d &'
                                  }])
  end

  it 'should create command' do
    command_params = { app_id: app.id, command_description: 'it does something', command: 'something -h' }
    post :create, params: command_params
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(message: 'Successfully created command')
    expect(response.body).to include_json(command:
                                              {
                                                  command_description: 'it does something',
                                                  command: 'something -h'
                                              })
  end

  it 'should update command' do
    command_params = { app_id: app.id, id: command.id,
                       command_description: 'it does something new', command: 'something -n' }
    patch :update, params: command_params
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(message: 'Successfully updated command')
    expect(response.body).to include_json(command:
                                              {
                                                  command_description: 'it does something new',
                                                  command: 'something -n'
                                              })
  end

  it 'should destroy command' do
    command_params = { app_id: app.id, id: command.id }
    delete :destroy, params: command_params
    expect(response).to have_http_status(200)
    expect(response.body).to include_json(message: 'Successfully deleted command')
  end
end