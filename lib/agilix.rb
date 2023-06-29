# require "active_support/all"
require "httparty"
require "ostruct"
require "agilix/buzz/configuration"
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

  def self.configuration
    @configuration ||= Agilix::Buzz::Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def initialize
    @agilix_buzz_username = self.class.configuration.agilix_buzz_username
    @agilix_buzz_password = self.class.configuration.agilix_buzz_password
    @agilix_buzz_domain = self.class.configuration.agilix_buzz_domain
  end
end

