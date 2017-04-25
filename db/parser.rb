require 'json'

# Parsers Rails Conf schedule to store in the database
class Parser

  attr_reader :schedule

  def initialize(file = 'railsconf2017-schedule-2017-04-20.json')
    schedule = File.read(file)
    @schedule = JSON.parse(schedule)
  end
end
