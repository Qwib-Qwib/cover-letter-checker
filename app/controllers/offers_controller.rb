class OffersController < ApplicationController
  def index
    @user = current_user
    @my_offers = @user.offers
  end

  def show
    @offer = Offer.find(params[:id])
    render file: "public/401.html", status: :unauthorized if @offer.user != current_user
    @offer_applications = @offer.job_applications
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    if @offer.save
      redirect_to offers_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:title, :content)
  end
end
