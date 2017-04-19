class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_play
  before_action :find_review, only: [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.play_id = @play.id
    @review.user_id = current_user.id

    if @review.save
      redirect_to play_path(@play)
    else
      flash[:alert] = "Hubo un error al crear la reseña, intentela de nuevo"
      render 'new'
    end
  end

  def update
    if @review.update(review_params)
      redirect_to play_path(@play)
    else
      flash[:alert] = "Hubo un error al actualizar la reseña, intentela de nuevo"
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to play_path(@play)
  end

  private
    def set_play
      @play = Play.find(params[:play_id])
    end

    def find_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
