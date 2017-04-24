require 'travis'

# They call him Travis, he has an API.
class TravisAPI
  attr_reader :travis

  def initialize
    @travis = Travis::Client.new
  end

  def build_status(repo)
    repo = @travis.repo(repo)
    colour = repo.color
    response_string = ""

    case colour
    when "green"
      response_string = "Build is green. Everything's shiny cap'n."
    when "yellow"
      response_string = "They call me mellow yellow. The build is still building"
    when "red"
      response_string = "Everyting isn't awesome. The build is broken."
    end
    response_string
  end

  def whoami
    puts "Hello #{@travis.user.name}"
  end
end
