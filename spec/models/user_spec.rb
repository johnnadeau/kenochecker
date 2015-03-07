require 'rails_helper'

RSpec.describe User do
  it 'has a valid factory' do
    user = FactoryGirl.build_stubbed(:user)
    expect(user).to be_valid
  end
end
