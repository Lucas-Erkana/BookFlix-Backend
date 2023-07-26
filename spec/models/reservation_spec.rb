require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before do
    @user = User.create(full_name: 'Saba Ahmed', email: 'saba@test.com', password: '123456')
    @location = Location.create(name: 'Punjab')
    @service = Service.create(name: 'Fast X', details: 'blah blah blah blah blah blah blah blah', price: 123,
                              duration: 3, image: 'https://demo.com/image.jpg', trailer: 'https://demo.com/trailer.mp4')
    @reservation = Reservation.new(user_id: @user.id, service_id: @service.id, location_id: @location.id,
                                   start_date: '2023-07-28', end_date: '2023-07-29')
  end

  it 'is valid with valid attributes' do
    expect(@reservation).to be_valid
  end
  it 'is not valid without a user_id' do
    @reservation.user_id = nil
    expect(@reservation).to_not be_valid
  end
  it 'is not valid without a service_id' do
    @reservation.service_id = nil
    expect(@reservation).to_not be_valid
  end

  it 'is not valid without a location_id' do
    @reservation.location_id = nil
    expect(@reservation).to_not be_valid
  end

  it 'is not valid without a start_date' do
    @reservation.start_date = nil
    expect(@reservation).to_not be_valid
  end

  it 'is not valid without a end_date' do
    @reservation.end_date = nil
    expect(@reservation).to_not be_valid
  end
end
