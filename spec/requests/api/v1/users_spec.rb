require 'swagger_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  path '/api/v1/users' do
    get 'Retrieve all users' do
      tags 'Users'
      produces 'application/json'
      response '200', 'Users found' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   full_name: { type: :string },
                   email: { type: :string },
                   role: { type: :string }
                 },
                 required: %w[id full_name email role]
               }

        run_test! do
          # Create some sample users for testing
          User.create!(full_name: 'John Doe', email: 'john@example.com', role: 'admin')
          User.create!(full_name: 'Jane Smith', email: 'jane@example.com', role: 'user')

          # Make a request to the '/api/v1/users' endpoint
          get '/api/v1/users'

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          users = JSON.parse(response.body)
          expect(users).to be_an(Array)
          expect(users.length).to eq(2)
          expect(users[0]).to include('id', 'full_name', 'email', 'role')
        end
      end
    end
  end
end
