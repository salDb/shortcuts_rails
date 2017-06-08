require 'test_helper'

class ShortcutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shortcut = shortcuts(:one)
  end

  test "should get index" do
    get shortcuts_url, as: :json
    assert_response :success
  end

  test "should create shortcut" do
    assert_difference('Shortcut.count') do
      post shortcuts_url, params: { shortcut: { action_name: @shortcut.action_name, first_action: @shortcut.first_action, fourth_action: @shortcut.fourth_action, second_action: @shortcut.second_action, third_action: @shortcut.third_action } }, as: :json
    end

    assert_response 201
  end

  test "should show shortcut" do
    get shortcut_url(@shortcut), as: :json
    assert_response :success
  end

  test "should update shortcut" do
    patch shortcut_url(@shortcut), params: { shortcut: { action_name: @shortcut.action_name, first_action: @shortcut.first_action, fourth_action: @shortcut.fourth_action, second_action: @shortcut.second_action, third_action: @shortcut.third_action } }, as: :json
    assert_response 200
  end

  test "should destroy shortcut" do
    assert_difference('Shortcut.count', -1) do
      delete shortcut_url(@shortcut), as: :json
    end

    assert_response 204
  end
end
