class PokemonController < ApplicationController
	def capture
		@pokemon_id = params[:id]
		@pokemon = Pokemon.find(params[:id])
		@pokemon.trainer = current_trainer
		if @pokemon.save
			redirect_to root_path
		end
	end

	def damage
		@pokemon_id = params[:id]
		@pokemon = Pokemon.find(params[:id])
		@pokemon.health = @pokemon.health - 10
		if @pokemon.save
			if @pokemon.health == 0
				@pokemon.destroy
			end
			redirect_to trainer_path(@pokemon.trainer.id)
		end
	end

    def create
      	@pokemon = Pokemon.create(pokemon_params)
      	@pokemon.level = 1
      	@pokemon.health = 100
      	@trainer = current_trainer
      	@pokemon.trainer = @trainer
      	if @pokemon.save #If saving the pokemon was successful
        	redirect_to trainer_path(@trainer.id)
        end
  	end

  	def new
  		@pokemon = Pokemon.new
  	end

  	private

  	def pokemon_params
    	params.require(:pokemon).permit(:name)
  	end
end
