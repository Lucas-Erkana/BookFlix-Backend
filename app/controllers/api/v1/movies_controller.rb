class Api::V1::MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render json: @movies
  end

  def show
    @movie = Movie.find_by(id: params[:id])
    if @movie
      render json: @movie, status: 200
    else
      render json: {
        error: 'Movie not found', status: 404
      }
    end
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render json: @movie, status: 200
    else
      render json: {
        error: 'Error creating service...'
      }
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    head :no_content
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :price, :image, :details, :duration, :rating, :trailer)
  end
end
