class TrainersController < ApplicationController
  before_filter :authenticate_trainer!

  def index
    @trainers = Trainer.all
  end

  def show
    @trainer = Trainer.find(params[:id])
  end

  # def update
  # 	pokemon = Pokemon.find(params[:id])
  # 	pokemon.trainer = current_trainer
  # 	redirect_to trainer_path(current_trainer.id)
  # end

	def update
		@trainer = Trainer.find(params[:id])
		@pokemon = Pokemon.new
		@pokemon.name = trainer_params[:name]
		@pokemon.health = 100
		@pokemon.level = 1
		@pokemon.trainer = @trainer
		if @pokemon.save
			redirect_to trainer_path(params[:id])
		else
			flash[:error] = @pokemon.errors.full_messages.to_sentence
			redirect_to new_pokemon_path
		end
	end

  private 

  def trainer_params
  	params.require(:trainer).permit(:name)
  end

end
