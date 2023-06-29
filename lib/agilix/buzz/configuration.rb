module Agilix::Buzz
  class Configuration
    attr_accessor :agilix_buzz_username, :agilix_buzz_password, :agilix_buzz_domain

    def initialize
      @agilix_buzz_username = nil
      @agilix_buzz_password = nil
      @agilix_buzz_domain = nil
    end

  end
end