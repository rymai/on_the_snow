require 'on_the_snow/client'

module OnTheSnow

  # Alias for OnTheSnow::Client.new
  #
  # @return [OnTheSnow::Client]
  #
  def self.new(options = {})
    OnTheSnow::Client.new(options)
  end

end
