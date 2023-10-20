class JobApplicationsController < ApplicationController
  def show
    @application = JobApplication.find(params[:id])
  end

  def new
    @offer = Offer.find(params[:offer_id])
    @application = JobApplication.new
  end

  def create
    @offer = Offer.find(params[:offer_id])
    @application = JobApplication.new(job_application_params)
    @application.offer = @offer
    if @application.save
      redirect_to offer_path(@offer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def job_application_params
    params.require(:job_application).permit(:applicant_name, :content, :analysis)
  end
end
