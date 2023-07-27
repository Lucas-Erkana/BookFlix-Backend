require 'swagger_helper'

RSpec.describe Api::V1::LocationsController, type: :request do
  path '/api/v1/locations' do
    get 'Retrieve all locations' do
      tags 'Locations'
      produces 'application/json'
      response '200', 'Locations found' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   name: { type: :string }
                 },
                 required: %w[id name]
               }

        run_test! do
          # Create some sample locations for testing
          Location.create!(name: 'Location 1')
          Location.create!(name: 'Location 2')

          # Make a request to retrieve all locations
          get '/api/v1/locations'

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          locations = JSON.parse(response.body)
          expect(locations).to be_an(Array)
          expect(locations.length).to eq(2)
          expect(locations[0]).to include('id', 'name')
        end
      end
    end

    post 'Create a location' do
      tags 'Locations'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :location, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response '200', 'Location created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               },
               required: %w[id name]

        let(:location) { { name: 'New Location' } }

        run_test! do
          # Make a request to create a location
          post '/api/v1/locations', params: { location: }

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          created_location = JSON.parse(response.body)
          expect(created_location).to include('id', 'name')
        end
      end

      response '200', 'Error creating location' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: ['error']

        let(:location) { { name: nil } }

        run_test! do
          # Make a request to create a location with invalid data
          post '/api/v1/locations', params: { location: }

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          error_response = JSON.parse(response.body)
          expect(error_response).to include('error')
        end
      end
    end
  end
end
