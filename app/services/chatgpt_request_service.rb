class ChatGPTRequestService
  include HTTParty

  attr_reader :api_url, :options, :model, :offer, :cover_letter

  def initialize(offer, cover_letter, model = 'gpt-3.5-turbo')
    api_key = Rails.application.credentials.chatgpt_api_key
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}"
      }
    }
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @model = model
    @offer = offer
    @cover_letter = cover_letter
  end

  def call
    body = {
      model:,
      messages: [
        { role: 'user', content: "Here are two extracts in French. The first one is a job offer, the second one is a cover letter for that offer. Compare them, explain the strengths and weaknesses of the candidate (in French and in an easily readable way), and end with your nuanced opinion on whether or not they'd be a good fit." },
        { role: 'user', content: offer},
        { role: 'user', content: cover_letter}
      ]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 10)
    raise response['error']['message'] unless response.code == 200

    response['choices'][0]['message']['content']
  end

  class << self
    def call(offer, cover_letter, model = 'gpt-3.5-turbo')
      new(offer, cover_letter, model).call
    end
  end
end
