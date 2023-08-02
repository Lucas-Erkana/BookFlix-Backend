require 'rails_helper'

RSpec.describe Location, type: :model do
  subject do
    @location = Location.new(name: 'Windhoek')
  end
  it 'should be valid' do
    expect(subject).to be_valid
  end
  it 'should be invalid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it 'should be invalid with a name less than 3 characters' do
    subject.name = 'ab'
    expect(subject).to_not be_valid
  end
  it 'should be invalid with a name more than 50 characters' do
    subject.name = 'a' * 51
    expect(subject).to_not be_valid
  end
end
