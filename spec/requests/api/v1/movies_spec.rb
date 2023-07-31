require 'swagger_helper'

RSpec.describe Api::V1::MoviesController, type: :request do
  path '/api/v1/movies' do
    get 'Retrieve all movies' do
      tags 'Movies'
      produces 'application/json'
      response '200', 'Movies found' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   price: { type: :number },
                   image: { type: :string },
                   details: { type: :string },
                   duration: { type: :number },
                   rating: { type: :number },
                   trailer: { type: :string }
                 },
                 required: %w[id name price image details duration rating]
               }

        run_test! do
          # Create some sample services for testing
          Movie.create!(name: 'Movie 1', price: 10.0, image: 'image1.jpg', details: 'Movie 1 Details', duration: 60,
                        rating: 4.5, trailer: 'trailer1.mp4')
          Movie.create!(name: 'Movie 2', price: 15.0, image: 'image2.jpg', details: 'Movie 2 Details', duration: 90,
                        rating: 3.8, trailer: 'trailer2.mp4')

          # Make a request to retrieve all services
          get '/api/v1/movies'

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          movies = JSON.parse(response.body)
          expect(movies).to be_an(Array)
          expect(movies.length).to eq(2)
          expect(movies[0]).to include('id', 'name', 'price', 'image', 'details', 'duration', 'rating', 'trailer')
        end
      end
    end

    post 'Create a Movie' do
      tags 'Movies'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :movie, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number },
          image: { type: :string },
          details: { type: :string },
          duration: { type: :number },
          rating: { type: :number },
          trailer: { type: :string }
        },
        required: %w[name price image details duration rating trailer]
      }

      response '200', 'Movie created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 price: { type: :number },
                 image: { type: :string },
                 details: { type: :string },
                 duration: { type: :number },
                 rating: { type: :number },
                 trailer: { type: :string }
               },
               required: %w[id name price image details duration rating trailer]

        let(:movie) do
          {
            name: 'New Movie',
            price: 20.0,
            image: 'new_image.jpg',
            details: 'New Movie Details',
            duration: 60,
            rating: 4.2,
            trailer: 'new_trailer.mp4'
          }
        end

        run_test! do
          # Make a request to create a movie
          post '/api/v1/movies', params: { movie: }

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          created_movie = JSON.parse(response.body)
          expect(created_movie).to include('id', 'name', 'price', 'image', 'details', 'duration', 'rating', 'trailer')
        end
      end

      response '200', 'Error creating movie' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: ['error']

        let(:movie) { { name: 'Invalid Movie', price: 'invalid' } }

        run_test! do
          # Make a request to create a movie with invalid data
          post '/api/v1/movies', params: { movie: }

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          error_response = JSON.parse(response.body)
          expect(error_response).to include('error')
        end
      end
    end
  end

  path '/api/v1/movies/{id}' do
    parameter name: :id, in: :path, type: :integer, required: true

    get 'Retrieve a movie' do
      tags 'Movies'
      produces 'application/json'
      response '200', 'Movie found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 price: { type: :number },
                 image: { type: :string },
                 details: { type: :string },
                 duration: { type: :number },
                 rating: { type: :number },
                 trailer: { type: :string }
               },
               required: %w[id name price image details duration rating trailer]

        let(:id) do
          Movie.create!(name: 'Movie 2', price: 15.0, image: 'image2.jpg', details: 'Movie 2 Details', duration: 90,
                        rating: 3.8, trailer: 'trailer2.mp4').id
        end

        run_test! do
          # Make a request to retrieve a Movie
          get "/api/v1/movies/#{id}"

          # Assert the response status code
          expect(response).to have_http_status(:ok)

          # Assert the response body against the defined schema
          movie = JSON.parse(response.body)
          expect(movie).to include('id', 'name', 'price', 'image', 'details', 'duration', 'rating', 'trailer')
        end
      end
    end

    delete 'Delete a movie' do
      tags 'Movies'
      produces 'application/json'
      response '204', 'Movie deleted' do
        let(:id) do
          Movie.create!(name: 'Movie 1', price: 10.0, image: 'image1.jpg', details: 'Movie 1 Details', duration: 60,
                        rating: 4.5, trailer: 'bucci.jpg').id
        end

        run_test! do
          # Make a request to delete a movie
          delete "/api/v1/movies/#{id}"

          # Assert the response status code
          expect(response).to have_http_status(:no_content)

          # Assert that the movie is deleted
          expect(Movie.find_by(id:)).to be_nil
        end
      end
    end
  end
end
