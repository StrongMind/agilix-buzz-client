
# require "active_support/all"
require "httparty"
require "ostruct"

require "agilix/buzz/commands/authentication"
require "agilix/buzz/commands/course"
require "agilix/buzz/commands/domain"
require "agilix/buzz/commands/enrollment"
require "agilix/buzz/commands/general"
require "agilix/buzz/commands/library"
require "agilix/buzz/commands/manifest"
require "agilix/buzz/commands/report"
require "agilix/buzz/commands/resource"
require "agilix/buzz/commands/right"
require "agilix/buzz/commands/user"

require "agilix/buzz/api"
require "agilix/version"



module Agilix
  module Buzz
    class Api::AuthenticationError < StandardError
      def initialize(msg="Could not Authenticate")
        super
      end
    end

  end
end
