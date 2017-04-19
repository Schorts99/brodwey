class PlaysController < ApplicationController
  before_action :find_play, except: [:index, :new, :create]
  before_action :show_categories, only: [:new, :edit]

  def index
    @plays = Play.all.order('created_at DESC')
  end

  def new
    @play = current_user.plays.build
  end

  def create
    @play = current_user.plays.build(play_params)
    @play.category_id = params[:category_id]

    if @play.save
      redirect_to root_path
    else
      flash[:alert] = "Hubo un error al crear la obra, intentela de nuevo"
      render 'new'
    end
  end

  def update
    @play.category_id = params[:category_id]

    if @play.update(play_params)
      redirect_to play_path(@play)
    else
      flash[:alert] = "Hubo un error al actualizar la obra, intentela de nuevo"
      render 'edit'
    end
  end

  def destroy
    @play.destroy
    redirect_to root_path
  end

  private
    def play_params
      params.require(:play).permit(:title, :description, :director, :category_id)
    end

    def find_play
      @play = Play.find(params[:id])
    end

    def show_categories
      @categories = Category.all.map{ |c| [c.name, c.id] }
    end
end
