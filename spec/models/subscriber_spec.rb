require 'rails_helper'

describe Subscriber do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end
end
