# It's all about the talks
class Talk < ApplicationRecord
  def self.find_talk(foo) # rubocop:disable Metrics/MethodLength
    days_of_conf = {'2017-04-22' => '1', '2017-04-23' => '2', '2017-04-24' => '3',
                    'today' => '1', 'tomorrow' => '2', 'thursday' => '3'}
    puts "FOO: #{foo.inspect}"
    date     = nil
    location = nil
    person   = nil
    talk     = nil
    time     = nil

    if foo['Date']
      date = days_of_conf[foo['Date']['value']]
    end
    if foo['SpokenDate']
      date = days_of_conf[foo['SpokenDate']['value']]
    end
    if foo['Talk']
      talk = foo['Talk']['value'].titlecase unless foo['Talk']['value'].blank?
    end
    if foo['Speaker']
      person = foo['Speaker']['value']
      if person == 'iron' # Gah Alexa keeps thinking I'm saying iron
        person = 'Aaron'
      end
    end
    if foo['Time']
      time = foo['Time']['value']
    end
    if foo['Location']
      location = foo['Location']['value'].titlecase unless foo['Location']['value'].blank?
    end

    results = finder(date, location, person, talk, time)
    puts "Results: #{results.inspect}"
    generate_response(results, location, person, talk, time)
  end

  def self.finder(date, location, person, talk, time)
    puts "DATE: #{date}"
    puts "Time: #{time}"
    puts "TALK: #{talk}"
    puts "LOCATION: #{location}"
    puts "PERSON: #{person}"
    results = ""
    if talk
      results = where(conference_day: date).where('title like ?', "%#{talk}%")
    end
    if person
      results = where('presenter like ?', "%#{person}%")
    end
    if time
      results = where(conference_day: date, start_time: time).where('room like ?', "%#{location}%")
    end
    results
  end

  def self.generate_response(results, location=nil, person=nil, talk=nil, time=nil)
    if results.nil?
      return "Sorry dude, couldn't understand the question. Please ask again"
    end
    if results.empty?
      return "Sorry dude, couldn't find a thing. Let's try that again"
    end
    response_string = ''
    if talk == 'Keynote'
      if results.size > 1
        response_string =
          "There are #{results.size} #{talk}s, both are in the #{results.first.room}"
      end
    end
    if person
      if results.size < 2
      response_string =
        "What an exciting talk that #{results.first.presenter} is giving. It's about #{results.first.title}, in room #{results.first.room} at #{results.first.start_time.strftime("%H:%M:%S")}."
        if results.first.presenter == "Aaron Patterson"
          response_string << " Let's hope he has some good puns, for once!"
        end
      end
    end
    if time
      if results.first.title == 'LUNCH' || results.first.title == 'AM BREAK' || results.first.title == 'PM BREAK'
        response_string = "Ooh such excite, looks like it's time for #{results.first.title}"
      else
        string_builder = ""
        results.each do |result|
          string_builder << "#{result.presenter}, #{result.title},"
        end
        response_string = "Well we have; #{string_builder}. Overall a pretty decent lineup. I think you should see #{results.sample.presenter}'s talk'"
      end
    end
    response_string
  end
end

# where(conference_day: date, room: location, presenter: person, start_time: time)
