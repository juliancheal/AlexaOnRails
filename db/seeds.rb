# {
# 	"conference_day": 1,
# 	"start_time": "14:30",
# 	"end_time": "15:10",
# 	"program_session_id": 113,
# 	"title": "Inventing Friends: ActionCable + AVS = \u003c3",
# 	"presenter": "Julian Cheal, Jonan Scheffler",
# 	"room": "156",
# 	"track": "Unconventional Rails",
# 	"description": "Chatbots, ActionCable, A.I. and you. And many more buzzwords
#    will enthral you in this talk.\r\n\r\nWe'll learn how to create a simple
#    chatroom in Rails using ActionCable, then how to talk to your colleagues
#    in the office or remote locations using text to speech and Amazon Voice
#    Service.\r\n\r\nUsing the power of ActionCable we will explore how its
#    possible to create an MMMOC: massively multiplayer online chatroom,
#    that you can use TODAY to see your; Travis Build status, or
#    deploy code to your favourite PAAS, let you know when the latest release of
#    Rails is out. Using nothing but your voice and ActionCable."
# }

require '../conf_schedule/parser'

parser = Parser.new('../conf_schedule/railsconf2017-schedule-2017-04-20.json')

# db fields ->
# conference_day
# start_time
# end_time
# program_session_id
# title
# presenter
# room
# track
# description

parser.schedule.each do |item|
  Talk.create(item)
end
