require 'rails_helper'

describe Room do
  describe 'relationships' do
    it { should have_many(:messages) }
    it { should have_many(:users).through(:messages) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
