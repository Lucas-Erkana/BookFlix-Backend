require 'swagger_helper'

RSpec.describe Api::V1::ReservationsController, type: :request do
  path '/api/v1/reservations' do
    get 'Retrieve all reservations' do
      tags 'Reservations'
      produces 'application/json'
      response '200', 'Reservations found' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   location_id: { type: :integer },
                   user_id: { type: :integer },
                   service_id: { type: :integer },
                   start_date: { type: :string, format: 'date-time' },
                   end_date: { type: :string, format: 'date-time' }
                 },
                 required: %w[id location_id user_id service_id start_date end_date]
               }

        run_test! do
          # Create some sample reservations for testing
          Reservation.create!(location_id: 1, user_id: 1, service_id: 1, start_date: DateTime.now,
                              end_date: DateTime.now + 1.day)
          Reservation.create!(location_id: 2, user_id: 2, service_id: 2, start_date: DateTime.now,
                              end_date: DateTime.now + 1.day)

          # Make a request to retrieve all reservations
          get '/api/v1/reservations'

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          reservations = JSON.parse(response.body)
          expect(reservations).to be_an(Array)
          expect(reservations.length).to eq(2)
          expect(reservations[0]).to include('id', 'location_id', 'user_id', 'service_id', 'start_date', 'end_date')
        end
      end
    end

    post 'Create a reservation' do
      tags 'Reservations'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          location_id: { type: :integer },
          user_id: { type: :integer },
          service_id: { type: :integer },
          start_date: { type: :string, format: 'date-time' },
          end_date: { type: :string, format: 'date-time' }
        },
        required: %w[location_id user_id service_id start_date end_date]
      }

      response '200', 'Reservation created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 location_id: { type: :integer },
                 user_id: { type: :integer },
                 service_id: { type: :integer },
                 start_date: { type: :string, format: 'date-time' },
                 end_date: { type: :string, format: 'date-time' }
               },
               required: %w[id location_id user_id service_id start_date end_date]

        let(:reservation) do
          {
            location_id: 1,
            user_id: 1,
            service_id: 1,
            start_date: DateTime.now,
            end_date: DateTime.now + 1.day
          }
        end

        run_test! do
          # Make a request to create a reservation
          post '/api/v1/reservations', params: { reservation: }

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          created_reservation = JSON.parse(response.body)
          expect(created_reservation).to include('id', 'location_id', 'user_id', 'service_id', 'start_date', 'end_date')
        end
      end

      response '200', 'Error creating reservation' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: ['error']

        let(:reservation) { { location_id: nil } }

        run_test! do
          # Make a request to create a reservation with invalid data
          post '/api/v1/reservations', params: { reservation: }

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          error_response = JSON.parse(response.body)
          expect(error_response).to include('error')
        end
      end
    end
  end

  path '/api/v1/reservations/{id}' do
    get 'Retrieve a reservation' do
      tags 'Reservations'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'Reservation found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 location_id: { type: :integer },
                 user_id: { type: :integer },
                 service_id: { type: :integer },
                 start_date: { type: :string, format: 'date-time' },
                 end_date: { type: :string, format: 'date-time' }
               },
               required: %w[id location_id user_id service_id start_date end_date]

        let(:id) do
          Reservation.create(location_id: 1, user_id: 1, service_id: 1, start_date: DateTime.now,
                             end_date: DateTime.now + 1.day).id
        end

        run_test! do
          # Make a request to retrieve a reservation
          get "/api/v1/reservations/#{id}"

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          reservation = JSON.parse(response.body)
          expect(reservation).to include('id', 'location_id', 'user_id', 'service_id', 'start_date', 'end_date')
        end
      end

      response '404', 'Reservation not found' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: ['error']

        let(:id) { 999 }

        run_test! do
          # Make a request to retrieve a non-existing reservation
          get "/api/v1/reservations/#{id}"

          # Assert the response status code
          expect(response).to have_http_status(:not_found)

          # Assert the response body against the defined schema
          error_response = JSON.parse(response.body)
          expect(error_response).to include('error')
        end
      end
    end

    delete 'Delete a reservation' do
      tags 'Reservations'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true

      response '204', 'Reservation deleted' do
        let(:id) do
          Reservation.create(location_id: 1, user_id: 1, service_id: 1, start_date: DateTime.now,
                             end_date: DateTime.now + 1.day).id
        end

        run_test! do
          # Make a request to delete a reservation
          delete "/api/v1/reservations/#{id}"

          # Assert the response status code
          expect(response).to have_http_status(:no_content)

          # Assert that the reservation is deleted
          expect(Reservation.find_by(id:)).to be_nil
        end
      end

      response '404', 'Reservation not found' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: ['error']

        let(:id) { 999 }

        run_test! do
          # Make a request to delete a non-existing reservation
          delete "/api/v1/reservations/#{id}"

          # Assert the response status code
          expect(response).to have_http_status(:not_found)

          # Assert the response body against the defined schema
          error_response = JSON.parse(response.body)
          expect(error_response).to include('error')
        end
      end
    end
  end
end
