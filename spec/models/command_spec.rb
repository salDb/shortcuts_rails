require 'rails_helper'

describe Command do
  describe 'Relationships' do
    it { should belong_to(:app) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:command_description) }
    it { should validate_presence_of(:command) }
  end
end
