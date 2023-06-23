require 'dotenv'
Dotenv.load

TEST_DOMAIN_ID            = '57025'
TEST_SUBDOMAIN_ID         = '57031'
TEST_SUBDOMAIN_ID2        = '57032'
TEST_USER_ID              = '57181'
TEST_USER_ID2             = '57176'
TEST_API_USER_ID          = '57026'
TEST_SOURCE_COURSE_ID     = '60982'
TEST_DEACTIVATE_COURSE_ID = '60990'
TEST_DELETE_COURSE_ID     = '60994'
TEST_MERGE_COURSE_ID      = '60995'
TEST_ENROLLMENT_ID        = '60997'
TEST_ROLE_ID              = '61316'
TEST_SUBSCRIBER_ID        = '57181'
TEST_FILE_NAME            = 'banner.css'
TEST_FILE_UPLOAD          = "test/agilix-logo.png"

require 'simplecov'
require 'pry'
require 'coveralls'
Coveralls.wear!

SimpleCov.formatters = [
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
]

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "agilix"

require "minitest/autorun"
require 'vcr'

VCR.configure do |c|
  c.default_cassette_options = { record: ENV["RECORD"] ? ENV["RECORD"].to_sym : :new_episodes, match_requests_on: [:query], erb: true }
  c.cassette_library_dir = "test/vcr/cassettes"
  c.hook_into :webmock
  c.filter_sensitive_data('<AGILIX_BUZZ_USERNAME>') { ENV["AGILIX_BUZZ_USERNAME"] }
  c.filter_sensitive_data('<AGILIX_BUZZ_PASSWORD>') { ENV["AGILIX_BUZZ_PASSWORD"] }
  c.filter_sensitive_data('api.agilixbuzz.com') { ENV["AGILIX_BUZZ_URL"] }
  c.filter_sensitive_data('agilixbuzz.com') { ENV["AGILIX_BUZZ_DOMAIN"] }



end

def api
  @api ||=  Agilix::Buzz::Api.new
  # @api ||= VCR.use_cassette("API Authenticate", match_requests_on: [:query]) do
  #   Agilix::Buzz::Api.new
  # end
end
