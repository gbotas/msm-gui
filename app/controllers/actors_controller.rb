class ActorsController < ApplicationController

  
  def create
    #Retrieve the user's inputs from params
    #Create a record in the movie table
    # Populate each column with the user input
    # Save
    # Redirect the user back to the /movies URL
  
    act = Actor.new
  
    act.name = params.fetch("name_box")
    act.dob = params.fetch("dob_box")
    act.bio = params.fetch("bio_box")
    act.image = params.fetch("image_box")
    
    act.save
  
    redirect_to("/actors")
  
  
    end 
  
    def destroy
      the_id = params.fetch("an_id")
  
      matching_actor= Actor.where({:id => the_id})
  
      the_actor = matching_actor.at(0)
  
      the_actor.destroy
      
      redirect_to("/actors")
  
    end 
  
    def edit
      #Get the ID out of params
      act_id = params.fetch("the_id")
  
      # Look up existing record
      matching_records = Actor.where({ :id => act_id})
      the_actor = matching_records.at(0)
  
      # Overwrite each columns with user inputs
      
      the_actor.name = params.fetch("name_box")
      the_actor.dob = params.fetch("dob_box")
      the_actor.bio = params.fetch("bio_box")
      the_actor.image = params.fetch("image_box")
  
  
      #Save
      the_actor.save
      #Redirect to movie details page
  
      redirect_to("/actors/#{the_actor.id}")
    end 

  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
