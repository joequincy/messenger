require 'rails_helper'

describe User do
  describe 'relationships' do
    it { should have_many(:messages) }
    it { should have_many(:subscribers) }
    it { should have_many(:rooms).through(:subscribers) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
