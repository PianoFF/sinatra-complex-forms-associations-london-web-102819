class OwnersController < ApplicationController

  get '/?' do
    redirect to :'/owners'
  end 

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do 
    @pets=Pet.all
    erb :'/owners/new'
  end

  post '/owners' do 
    @pets=Pet.all
    #activerecord mass assignment. binding.pry to see the params value
    #in it,it can be: pet_ids=>["1","2"]. ActiveRecord automatically assocaite the pets that have these ids to this owner.
    @owner=Owner.create(params[:owner])

    #if params["pet"]["name"] is not empty, then create this new pet instance and "push" it to update the relationship.
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    redirect to :"owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets=Pet.all 
    erb :'/owners/edit'
  end

  get '/owners/:id' do #show 
    @owner = Owner.find(params[:id])
  
    erb :'/owners/show'
  end

  patch '/owners/:id' do 

    ###bug fix: if a user deselected everything, Sinatra doesn't generate an empty array for this key, thereofre, manually add it!
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"]=[]
    end 

    @owner=Owner.find(params[:id])
    @owner.update(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to :"owners/#{@owner.id}"
  end
end