require 'rails_helper'

describe Shortcut do
  describe 'Relationships' do
    it { should belong_to(:app) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:action_name) }
    it { should validate_presence_of(:first_action) }
    it { should validate_presence_of(:second_action) }
  end
end
