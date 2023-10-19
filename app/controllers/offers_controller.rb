class OffersController < ApplicationController
  def index
    @user = User.find(params[:id])
    @my_offers = @user.offers
  end

  def new
    @user = User.find(params[:id])
    @offer = Offer.new
  end

  def create
    @user = User.find(params[:id])
    @offer = Offer.new(params[:offer])
    if @offer.save
      redirect_to root
    else
      render :new, status: :unprocessable_entity
    end
  end
end
