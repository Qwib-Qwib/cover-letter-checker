class JobApplicationsController < ApplicationController
  def show

  end

  def new

  end

  def create

  end

  private

  def job_application_params
    params.require(:job_application).permit(:applicant_name, :content, :analysis)
  end
end
