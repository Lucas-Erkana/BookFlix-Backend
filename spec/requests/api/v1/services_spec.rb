require 'swagger_helper'

RSpec.describe Api::V1::ServicesController, type: :request do
  path '/api/v1/services' do
    get 'Retrieve all services' do
      tags 'Services'
      produces 'application/json'
      response '200', 'Services found' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   price: { type: :number },
                   image: { type: :string },
                   details: { type: :string },
                   duration: { type: :integer },
                   rating: { type: :number }
                 },
                 required: %w[id name price image details duration rating]
               }

        run_test! do
          # Create some sample services for testing
          Service.create!(name: 'Service 1', price: 10.0, image: 'image1.jpg', details: 'Details 1', duration: 60,
                          rating: 4.5)
          Service.create!(name: 'Service 2', price: 15.0, image: 'image2.jpg', details: 'Details 2', duration: 90,
                          rating: 3.8)

          # Make a request to retrieve all services
          get '/api/v1/services'

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          services = JSON.parse(response.body)
          expect(services).to be_an(Array)
          expect(services.length).to eq(2)
          expect(services[0]).to include('id', 'name', 'price', 'image', 'details', 'duration', 'rating')
        end
      end
    end

    post 'Create a service' do
      tags 'Services'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :service, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number },
          image: { type: :string },
          details: { type: :string },
          duration: { type: :integer },
          rating: { type: :number }
        },
        required: %w[name price image details duration rating]
      }

      response '200', 'Service created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 price: { type: :number },
                 image: { type: :string },
                 details: { type: :string },
                 duration: { type: :integer },
                 rating: { type: :number }
               },
               required: %w[id name price image details duration rating]

        let(:service) do
          {
            name: 'New Service',
            price: 20.0,
            image: 'new_image.jpg',
            details: 'New Service Details',
            duration: 120,
            rating: 4.2
          }
        end

        run_test! do
          # Make a request to create a service
          post '/api/v1/services', params: { service: }

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          created_service = JSON.parse(response.body)
          expect(created_service).to include('id', 'name', 'price', 'image', 'details', 'duration', 'rating')
        end
      end

      response '200', 'Error creating service' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: ['error']

        let(:service) { { name: 'Invalid Service', price: 'invalid' } }

        run_test! do
          # Make a request to create a service with invalid data
          post '/api/v1/services', params: { service: }

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          error_response = JSON.parse(response.body)
          expect(error_response).to include('error')
        end
      end
    end
  end

  path '/api/v1/services/{id}' do
    parameter name: :id, in: :path, type: :integer, required: true

    get 'Retrieve a service' do
      tags 'Services'
      produces 'application/json'
      response '200', 'Service found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 price: { type: :number },
                 image: { type: :string },
                 details: { type: :string },
                 duration: { type: :integer },
                 rating: { type: :number }
               },
               required: %w[id name price image details duration rating]

        let(:id) do
          Service.create(name: 'Service 1', price: 10.0, image: 'image1.jpg', details: 'Details 1', duration: 60,
                         rating: 4.5).id
        end

        run_test! do
          # Make a request to retrieve a service
          get "/api/v1/services/#{id}"

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          service = JSON.parse(response.body)
          expect(service).to include('id', 'name', 'price', 'image', 'details', 'duration', 'rating')
        end
      end

      response '404', 'Service not found' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: ['error']

        let(:id) { 999 }

        run_test! do
          # Make a request to retrieve a non-existing service
          get "/api/v1/services/#{id}"

          # Assert the response status code
          expect(response).to have_http_status(:not_found)

          # Assert the response body against the defined schema
          error_response = JSON.parse(response.body)
          expect(error_response).to include('error')
        end
      end
    end

    delete 'Delete a service' do
      tags 'Services'
      produces 'application/json'
      response '204', 'Service deleted' do
        let(:id) do
          Service.create(name: 'Service 1', price: 10.0, image: 'image1.jpg', details: 'Details 1', duration: 60,
                         rating: 4.5).id
        end

        run_test! do
          # Make a request to delete a service
          delete "/api/v1/services/#{id}"

          # Assert the response status code
          expect(response).to have_http_status(:no_content)

          # Assert that the service is deleted
          expect(Service.find_by(id:)).to be_nil
        end
      end

      response '404', 'Service not found' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: ['error']

        let(:id) { 999 }

        run_test! do
          # Make a request to delete a non-existing service
          delete "/api/v1/services/#{id}"

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
