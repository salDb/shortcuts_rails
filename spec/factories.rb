include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    password '123456'
    password_confirmation '123456'
  end

  factory :app do
    name 'App'
    image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'test.png'), 'image/png') }
    user_id ''
  end

  factory :shortcut do
    action_name 'saves a file'
    first_action 'ctrl'
    second_action's'
    app_id ''
  end
end