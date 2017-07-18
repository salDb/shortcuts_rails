require 'rails_helper'

describe App do
  describe 'Relationships' do
    it { should belong_to(:user) }
    it { should have_many(:shortcuts) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:image) }
  end
end
