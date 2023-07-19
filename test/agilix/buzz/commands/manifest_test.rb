require 'test_helper'

class Agilix::Buzz::Commands::ManifestTest < Minitest::Test
  describe "#update_manifest_data" do
    it 'updates manifest data' do
      VCR.use_cassette("Commands::Manifest update_manifest_data", match_requests_on: [:query]) do
        response = api.update_manifest_data({ "Manifests": [
          {
            "EntityId": "196363507",
            "Data": {
              "AllowStaticCopy": false,
              "AllowDerivativeChildCopy": true,
              "AllowDerivativeSiblingCopy": false,
              "GradeCategories": {
                "Weighted": true,
                "Categories": [
                  {
                    "Id": 1,
                    "GradeView": 0,
                    "Name": "Checkpoint",
                    "AlphaIndex": "aa",
                    "Weight": 15
                  },
                  {
                    "Id": 2,
                    "GradeView": 0,
                    "Name": "Discussion",
                    "AlphaIndex": "ab",
                    "Weight": 15
                  },
                  {
                    "Id": 3,
                    "GradeView": 0,
                    "Name": "Exam",
                    "AlphaIndex": "ac",
                    "Weight": 15
                  },
                  {
                    "Id": 4,
                    "GradeView": 0,
                    "Name": "Final Exam",
                    "AlphaIndex": "ad",
                    "Weight": 15
                  },
                  {
                    "Id": 5,
                    "GradeView": 0,
                    "Name": "Pretest",
                    "AlphaIndex": "ae",
                    "Weight": 0
                  },
                  {
                    "Id": 6,
                    "GradeView": 0,
                    "Name": "Project",
                    "AlphaIndex": "af",
                    "Weight": 30
                  },
                  {
                    "Id": 7,
                    "GradeView": 0,
                    "Name": "Workbook",
                    "AlphaIndex": "ag",
                    "Weight": 10
                  }
                ]
              },
              "Description": "",
              "GradeView": "",
              "ThumbnailPath": "",
              "LandingPagePath": {
                "Value": "assets/syllabus.html"
              }
            }
          }
        ]
                                            })
        puts "manifest response: #{response.inspect}"
      end
    end
  end
end