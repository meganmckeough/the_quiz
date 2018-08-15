class GamesUsersController < ApplicationController

	def create
		#hardcoded to user, later change to current_user
		@user = User.find_by(name: 'Kate')
		@game = Game.find_by(code: params[:code])
		if @game
			@games_user = GamesUser.new
			@games_user.user_id = @user.id
			@games_user.game_id = @game.id
			@games_user.save
			redirect_to "/games/#{ @game.id }"
		else
			redirect_to "/games/new"
		end 
	end

	def update
		@user = helper.current_user
		@game = Game.find_by(id: params[:id])

		user_record = GamesUser.find_by(game_id: @game.id)
		user_record.score = params[:score]

		if user_record.save
			render :win
		else 
			redirect_to '/'
		end
	end

end
