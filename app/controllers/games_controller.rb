class GamesController < ApplicationController
  before_action :set_game, only: %i[new create edit destroy]

  def index
    @games = Game.all
  end

  def show

  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @game.destroy
    redirect_to games_path, status: :see_other
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def game_params
    params.require(:game).permit(:name, :description, :price, :gender, :team_size, :pitch_identifier, :pitch_type, :indoor, :address, :starting_date, :ending_date, :recurring_rule)
    params.require(:game).permit(:name, :description, :price, :gender, :team_size, :pitch_identifier, :pitch_type, :address, :starting_date, :ending_date, :recurring_rule)
  end

  def schedule_to_yaml(game, schedule)
    game.recurring_rule = schedule.to_yaml
  end

  def yaml_to_schedule(game)
    hash = Psych.safe_load(game.recurring_rule, permitted_classes: [Time, Symbol])
    IceCube::Schedule.from_hash(hash)
  end
end

# IceCube::Schedule.new(now = Time.now)
# schedule.add_recurrence_rule(IceCube::Rule.weekly.day(:saturday).hour_of_day(10, 11))
