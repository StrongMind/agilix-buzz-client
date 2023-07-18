require 'test_helper'

class Agilix::Buzz::Commands::ManifestTest < Minitest::Test
  describe "#update_manifest_data" do
    it 'updates manifest data' do
      VCR.use_cassette("Commands::Manifest update_manifest_data", match_requests_on: [:query]) do
        response = api.update_manifest_data [ { entityid: TEST_COURSE_ID }]
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end
end