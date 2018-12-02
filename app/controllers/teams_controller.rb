##
#
class TeamsController < ApplicationController
  skip_before_action :authenticate_request, only: [:get_sample]
  before_action :set_team, only: [:show, :update, :destroy]

  def get_sample    
    team = Team.limit(10).order("RANDOM()")
    render json: {count: 10, teams: team}, status: :ok
  end

  def index
    cnt = Team.count
    teams = Team.all.page(params[:page]).per(params[:limit])
    render json: {count: cnt, tems: teams}, status: :ok
    rescue
      render json: {message: 'Not found'}, status: :not_found
  end

  def show
    render json: @team
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if @team.save
      render json: @team, status: :created, location: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def update
    if current_user.id != @team.user_id
      return  render json: {message: 'Unprocessable entity'}, status: :unprocessable_entity  
    end
    if @team.update(team_params)
      render json: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.permit(:title, :summary, :body, :picture, :page, :limit)
    end
end
