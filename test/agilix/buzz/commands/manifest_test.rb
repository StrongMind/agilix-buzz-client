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

  describe "#put_items" do
    it 'puts items in the manifest' do
      VCR.use_cassette("Commands::Manifest put_items", match_requests_on: [:query], record: :new_episodes) do
        response = api.put_items(
          {
            "items":[
              {
                "entityId":"196363507",
                "id":"Resources",
                "itemData":{
                  "parentId":{
                    "value":"DEFAULT"
                  },
                  "title":{
                    "value":"Resources"
                  },
                  "gradingCategoryId":"",
                  "weight":"",
                  "gradeFlags":"",
                  "maxAttempts":"",
                  "thumbnailPath":"",
                  "sequence":{
                    "value":"aa"
                  },
                  "resourcesPath":"",
                  "contentHref":"",
                  "itemType":{
                    "value":4
                  },
                  "isGradable":"",
                  "completionTrigger":"",
                  "allowFileSubmissions":"",
                  "fileSubmissionType":"",
                  "visibility":{
                    "value":8
                  },
                  "customFields":""
                },
                "children":[]
              },
              {
                "entityId":"196363507",
                "id":"Resources_Instruction_2a13b0f2-5f4a-46f1-8d1d-06c60802dc8e",
                "itemData":{
                  "parentId":{
                    "value":"Resources"
                  },
                  "title":{
                    "value":"Teacher Resource Guide"
                  },
                  "gradingCategoryId":"",
                  "weight":"",
                  "gradeFlags":"",
                  "maxAttempts":"",
                  "thumbnailPath":"",
                  "sequence":{
                    "value":"aa"
                  },
                  "resourcesPath":"",
                  "contentHref":{
                    "value":"bltis://h2.flipswitch.com:443/FSProviderLaunch/26319?revisionid=70051\u0026smcatalogid=1278\u0026label=2d7455ab-ddf8-45dd-9890-c7c73dc08ab4"
                  },
                  "itemType":{
                    "value":6
                  },
                  "isGradable":"",
                  "completionTrigger":"",
                  "allowFileSubmissions":"",
                  "fileSubmissionType":"",
                  "visibility":{
                    "value":8
                  },
                  "customFields":""
                },
                "children":[]
              },
              {
                "entityId":"196363507",
                "id":"Unit_42891",
                "itemData":{
                  "parentId":{
                    "value":"DEFAULT"
                  },
                  "title":{
                    "value":"Unit 1: Expressions"
                  },
                  "gradingCategoryId":"",
                  "weight":"",
                  "gradeFlags":"",
                  "maxAttempts":"",
                  "thumbnailPath":{
                    "value":"assets/Unit_42891/Unit_42891_IntroductionImage.png"
                  },
                  "sequence":{
                    "value":"ab"
                  },
                  "resourcesPath":"",
                  "contentHref":{
                    "value":"assets/Unit_42891/Unit_42891_Introduction.html"
                  },
                  "itemType":{
                    "value":4
                  },
                  "isGradable":"",
                  "completionTrigger":"",
                  "allowFileSubmissions":"",
                  "fileSubmissionType":"",
                  "visibility":{
                    "value":0
                  },
                  "customFields":""
                }
              }
            ]
        })
        assert response.success?
      end
    end
  end
end