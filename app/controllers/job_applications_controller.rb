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

    # @application.analysis = retrieve_chatgpt_response
    @application.analysis = generate_fake_para

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

  def retrieve_chatgpt_response
    client = OpenAI::Client.new
    chat_gpt_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: 'user', content: "Here are two extracts in French. The first one is a job offer, the second one is a cover letter for that offer. Compare them, explain the strengths and weaknesses of the candidate (in French and in an easily readable way), and end with your nuanced opinion on whether or not they'd be a good fit." },
          { role: 'user', content: @offer.content},
          { role: 'user', content: @application.content}
        ],
        temperature: 0.2,
      }
    )
    # raise chat_gpt_response['error']['message'] unless chat_gpt_response.code == 200
    chat_gpt_response['choices'][0]['message']['content']
  end

  # Temporary method, to be removed once I get an API key.
  def generate_fake_para
    Faker::Lorem.paragraphs(number: 4).join(" ")
  end
end
