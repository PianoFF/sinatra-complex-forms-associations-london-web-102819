class PetsController < ApplicationController

  
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @pets=Pet.all 
    @owners=Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    #mass assignment: creating new pet with association to an owner via owner_id. check the params via binding.pry
    @pet=Pet.create(params[:pet])
    # binding.pry
    if params[:owner][:name]!=""
      @owner=Owner.create(params[:owner])
      @owner.pets<<@pet 
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owner=@pet.owner 
    # binding.pry 
    if @owner==nil
      @owner_name="not owned yet"
    else 
      @owner_name=@owner.name 
    end 
    erb :'/pets/show'
  end

  get '/pets/:id/edit'do
    @pet=Pet.find(params[:id])
    @owners=Owner.all 

    erb :"pets/edit"
  end
  patch '/pets/:id' do 
    @pet=Pet.find(params[:id])
    @pet.update(params[:pet])
    if params[:owner][:name]!=""
      @owner=Owner.create(params[:owner])
      @owner.pets<<@pet 
    end
    redirect to "pets/#{@pet.id}"
  end
end