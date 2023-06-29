
# require "active_support/all"
require "httparty"
require "ostruct"

require "agilix/buzz/commands/authentication"
require "agilix/buzz/commands/course"
require "agilix/buzz/commands/domain"
require "agilix/buzz/commands/enrollment"
require "agilix/buzz/commands/general"
require "agilix/buzz/commands/library"
require "agilix/buzz/commands/report"
require "agilix/buzz/commands/resource"
require "agilix/buzz/commands/right"
require "agilix/buzz/commands/user"

require "agilix/buzz/api"
require "agilix/buzz/configuration"
require "agilix/version"



module Agilix
  class << self
    attr_accessor :configuration
  end


  autoload :Agilix, "agilix/version"

  autoload :Api, "agilix/buzz/api"
  autoload :Configuration, "agilix/buzz/configuration"

  autoload :Authentication, "agilix/buzz/commands/authentication"
  autoload :Course, "agilix/buzz/commands/course"
  autoload :Domain, "agilix/buzz/commands/domain"
  autoload :Enrollment, "agilix/buzz/commands/enrollment"
  autoload :General, "agilix/buzz/commands/general"
  autoload :Library, "agilix/buzz/commands/library"
  autoload :Report, "agilix/buzz/commands/report"
  autoload :Resource, "agilix/buzz/commands/resource"
  autoload :Right, "agilix/buzz/commands/right"
  autoload :User, "agilix/buzz/commands/user"

  # Classes used to return a nicer object wrapping the response data
  # autoload :Group, "schoology/objects/group"

  def self.configuration
    @configuration ||= Agilix::Buzz::Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def initialize
    @agilix_buzz_username = self.class.configuration.oauth_consumer_key
    @agilix_buzz_password = self.class.configuration.oauth_consumer_secret
    @agilix_buzz_domain = self.class.configuration.url
  end
end

