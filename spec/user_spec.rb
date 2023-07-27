require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    @user = User.new(full_name: 'Faronsh', email: 'faronosh@test.com', password: 'far123.,')
  end

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should be invalid without a full_name' do
    subject.full_name = nil
    expect(subject).to_not be_valid
  end

  it 'should be invalid without email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'should be invalid without password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'should be invalid with a full_name less than 3 characters' do
    subject.full_name = 'ab'
    expect(subject).to_not be_valid
  end

  it 'should be invalid with a password less than 6 characters' do
    subject.password = '12345'
    expect(subject).to_not be_valid
  end
end
