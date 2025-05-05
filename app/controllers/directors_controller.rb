class DirectorsController < ApplicationController


  def create
    #Retrieve the user's inputs from params
    #Create a record in the movie table
    # Populate each column with the user input
    # Save
    # Redirect the user back to the /movies URL
  
    dir = Director.new
  
    dir.name = params.fetch("name_box")
    dir.dob = params.fetch("dob_box")
    dir.bio = params.fetch("bio_box")
    dir.image = params.fetch("image_box")
    
    dir.save
  
    redirect_to("/directors")
  
  
    end 
  
    def destroy
      the_id = params.fetch("an_id")
  
      matching_director= Director.where({:id => the_id})
  
      the_director = matching_director.at(0)
  
      the_director.destroy
      
      redirect_to("/directors")
  
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
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
