
require 'alexa_generator'
require 'json'

interaction_model = AlexaGenerator::InteractionModel.build do |model|
  model.add_intent(:RailsConf) do |intent|
    intent.add_slot(:Date, AlexaGenerator::Slot::SlotType::DATE) do |slot|
      slot.add_bindings('today', 'tomorrow', 'day after tomorrow', 'tuesday',
                        'wednesday', 'thursday')
    end

    intent.add_utterance_template('Which room is {Date}​ keynote​')
  end
end

puts JSON.pretty_generate(interaction_model.intent_schema)

puts interaction_model.sample_utterances(:RailsConf)
