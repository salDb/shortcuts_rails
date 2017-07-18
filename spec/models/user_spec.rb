require 'rails_helper'

describe User do
  describe 'Relationships' do
    it { should have_many(:apps) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
  end
end
