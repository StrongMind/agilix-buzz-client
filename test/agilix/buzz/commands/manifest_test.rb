require 'test_helper'

class Agilix::Buzz::Commands::ManifestTest < Minitest::Test
  describe "#update_manifest_data" do
    it 'updates manifest data' do
      VCR.use_cassette("Commands::Manifest update_manifest_data", match_requests_on: [:query]) do
        response = api.update_manifest_data(
              { "manifest": [
                {
                  "entityId": "196363507",
                  "data": {
                    "allowStaticCopy": false,
                    "allowDerivativeChildCopy": true,
                    "allowDerivativeSiblingCopy": false,
                    "gradeCategories": {
                      "weighted": true,
                      "categories": [
                        {
                          "id": 1,
                          "gradeView": 0,
                          "name": "Checkpoint",
                          "alphaIndex": "aa",
                          "weight": 15
                        },
                        {
                          "id": 2,
                          "gradeView": 0,
                          "name": "Discussion",
                          "alphaIndex": "ab",
                          "weight": 15
                        },
                        {
                          "id": 3,
                          "gradeView": 0,
                          "name": "Exam",
                          "alphaIndex": "ac",
                          "weight": 15
                        },
                        {
                          "id": 4,
                          "gradeView": 0,
                          "name": "Final Exam",
                          "alphaIndex": "ad",
                          "weight": 15
                        },
                        {
                          "id": 5,
                          "gradeView": 0,
                          "name": "Pretest",
                          "alphaIndex": "ae",
                          "weight": 0
                        },
                        {
                          "id": 6,
                          "gradeView": 0,
                          "name": "Project",
                          "alphaIndex": "af",
                          "weight": 30
                        },
                        {
                          "id": 7,
                          "gradeView": 0,
                          "name": "Workbook",
                          "alphaIndex": "ag",
                          "weight": 10
                        }
                      ]
                    },
                    "description": "",
                    "gradeView": "",
                    "thumbnailPath": "",
                    "landingPagePath": {
                      "value": "assets/syllabus.html"
                    }
                  }
                }
              ]
              })
        assert response.success?
      end
    end
  end
end