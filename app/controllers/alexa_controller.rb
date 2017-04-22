require 'alexa_rubykit'
# Uber Alexa Controller. Can you even control Alexa?
class AlexaController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    alexa = AlexaRubykit.build_request(JSON.parse(request.body.read.to_s))

    # @intent={"name"=>"RailsConfTalks", "slots"=>{"Date"=>{"name"=>"Date"}}},
    # @type="INTENT_REQUEST", @name="RailsConfTalks",
    # @slots={"Date"=>{"name"=>"Date"}}>

    response = generate_response(alexa)

    render json: response
  end

  private

  def generate_response(alexa) # rubocop:disable Metrics/MethodLength
    alexa_response = AlexaRubykit::Response.new

    speach_string = which_demo_am_i_calling(alexa)
    puts speach_string

    case alexa.type
    when 'INTENT_REQUEST'
      alexa_response.add_speech(speach_string)
      alexa_response.add_hash_card(title: 'AlexaOnRails',
                                   subtitle: "Intent #{alexa.name}")
    when 'SESSION_ENDED_REQUEST'
      halt 200
    end
    alexa_response.build_response
  end

  def which_demo_am_i_calling(which_one)
    response_string = ''
    case which_one.name
    when 'RailsConfTalks'
      response_string = Talk.find_talk(which_one.slots)
    end
    response_string
  end
end
