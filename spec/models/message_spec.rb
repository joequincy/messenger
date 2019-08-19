require 'rails_helper'

describe Message do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
  end
end
