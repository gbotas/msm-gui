class MoviesController < ApplicationController



  def create
  #Retrieve the user's inputs from params
  #Create a record in the movie table
  # Populate each column with the user input
  # Save
  # Redirect the user back to the /movies URL

  m = Movie.new

  m.title = params.fetch("title_box")
  m.year = params.fetch("year_box")
  m.duration = params.fetch("duration_box")
  m.description = params.fetch("description_box") 
  m.image = params.fetch("image_box")
  m.director_id = params.fetch("director_id_box")

  m.save

  redirect_to("/movies")


  end 

  def destroy
    the_id = params.fetch("an_id")

    matching_movie= Movie.where({:id => the_id})

    the_movie = matching_movie.at(0)

    the_movie.destroy
    
    redirect_to("/movies")

  end 

  def edit
    #Get the ID out of params
    m_id = params.fetch("the_id")

    # Look up existing record
    matching_records = Movie.where({ :id => m_id})
    the_movie = matching_records.at(0)

    # Overwrite each columns with user inputs
    
    the_movie.title = params.fetch("title_box")
    the_movie.year = params.fetch("year_box")
    the_movie.duration = params.fetch("duration_box")
    the_movie.description = params.fetch("description_box") 
    the_movie.image = params.fetch("image_box")
    the_movie.director_id = params.fetch("director_id_box")

    #Save
    the_movie.save
    #Redirect to movie details page

    redirect_to("/movies/#{the_movie.id}")
  end 

  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
