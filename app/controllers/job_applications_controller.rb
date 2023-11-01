class JobApplicationsController < ApplicationController
  before_action :authenticate_user!, only: %i[show new create]

  def show
    @application = JobApplication.find(params[:id])
    render file: "public/401.html", status: :unauthorized if @application.offer.user != current_user
    @offer = @application.offer
  end

  def new
    @offer = Offer.find(params[:offer_id])
    render file: "public/401.html", status: :unauthorized if @offer.user != current_user
    @application = JobApplication.new
  end

  def create
    @offer = Offer.find(params[:offer_id])
    render file: "public/401.html", status: :unauthorized if @offer.user != current_user
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
          { role: 'user', content: "You will be prompted by recruiters with two extracts in French. The first one is a job offer, the second one is a cover letter for that offer. Help the recruiter judge the applicant by comparing both inputs and explaining the strengths and weaknesses of the applicant relative to the job offer with a few bullet points. End with your nuanced opinion on whether or not they'd be a good fit. Your answer must be in French." },
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
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. At consectetur lorem donec massa sapien faucibus. Tincidunt praesent semper feugiat nibh sed pulvinar proin gravida. Sed libero enim sed faucibus turpis in eu mi. Mattis vulputate enim nulla aliquet porttitor lacus luctus accumsan. Vitae aliquet nec ullamcorper sit amet risus nullam eget felis. Sit amet consectetur adipiscing elit ut aliquam purus sit amet. Eget sit amet tellus cras adipiscing enim eu turpis. In hac habitasse platea dictumst. Malesuada fames ac turpis egestas sed tempus urna et pharetra. Vulputate ut pharetra sit amet. Pulvinar sapien et ligula ullamcorper malesuada.

    Et ultrices neque ornare aenean euismod elementum nisi quis. Placerat vestibulum lectus mauris ultrices eros in cursus. Ac tincidunt vitae semper quis lectus. Id volutpat lacus laoreet non curabitur gravida arcu ac tortor. Pellentesque elit eget gravida cum sociis natoque. Purus semper eget duis at tellus at. A diam sollicitudin tempor id eu nisl. Viverra aliquet eget sit amet tellus cras adipiscing enim eu. Nisi porta lorem mollis aliquam ut porttitor leo a. Blandit volutpat maecenas volutpat blandit aliquam etiam erat. Urna condimentum mattis pellentesque id nibh. Urna molestie at elementum eu facilisis sed. Sit amet purus gravida quis. Gravida neque convallis a cras semper auctor neque vitae. Commodo nulla facilisi nullam vehicula ipsum a arcu cursus. Morbi non arcu risus quis varius. Pellentesque habitant morbi tristique senectus et netus et. Integer vitae justo eget magna fermentum. Rutrum quisque non tellus orci ac.

    Volutpat diam ut venenatis tellus. Leo integer malesuada nunc vel risus commodo viverra. Sit amet nulla facilisi morbi tempus iaculis. Sed id semper risus in hendrerit gravida rutrum quisque. Faucibus turpis in eu mi. Phasellus vestibulum lorem sed risus. Nibh nisl condimentum id venenatis a condimentum vitae. Ultrices vitae auctor eu augue ut lectus arcu bibendum at. Odio aenean sed adipiscing diam donec adipiscing tristique risus. Quam viverra orci sagittis eu volutpat. Adipiscing vitae proin sagittis nisl. Facilisis mauris sit amet massa vitae. Egestas tellus rutrum tellus pellentesque eu tincidunt tortor aliquam. Diam donec adipiscing tristique risus nec feugiat."
  end
end
