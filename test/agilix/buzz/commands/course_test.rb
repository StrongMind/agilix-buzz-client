require "test_helper"

class Agilix::Buzz::Commands::CourseTest < Minitest::Test

  describe '#copy_courses' do
    it "Copies a course to a domain" do
      VCR.use_cassette("Commands::Course copy_courses course #{TEST_SOURCE_COURSE_ID} to domain #{TEST_SUBDOMAIN_ID}", match_requests_on: [:query]) do
        response = api.copy_courses [{domainid: TEST_SUBDOMAIN_ID, courseid: TEST_SOURCE_COURSE_ID }]
        assert response.success?
        course_response = response.dig('response', 'responses', 'response').first
        assert_equal "OK", course_response['code']
        assert !course_response['course'].empty?
      end
    end
  end

  describe '#create_courses' do
    it "Creates courses" do
      VCR.use_cassette("Commands::Course create_courses new course for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.create_courses [{domainid: TEST_DOMAIN_ID, title: "Test Course", status: 1, type: "Continuous"}]
        assert response.success?
        course_response = response.dig('response', 'responses', 'response').first
        assert_equal "OK", course_response['code']
        assert !course_response['course'].empty?
      end
    end
  end

  describe '#create_demo_course' do
    it "Creates demo course" do
      VCR.use_cassette("Commands::Course create_demo_course for domain #{TEST_DOMAIN_ID} from course #{TEST_SOURCE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.create_demo_course courseid: TEST_SOURCE_COURSE_ID, domainid: 57025, title: "Demo Course", daysoffset: 60
        assert response.success?
        assert_equal "OK", response.dig('response', 'code')
        assert !response.dig('response', 'course', 'courseid').empty?
      end
    end
  end

  describe '#deactivate_course' do
    it "Deactivates a courses by id " do
      VCR.use_cassette("Commands::Course deactivate_course for course #{TEST_DEACTIVATE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.deactivate_course courseid: TEST_DEACTIVATE_COURSE_ID
        assert response.success?
        assert_equal "OK", response.dig('response', 'code')
      end
    end
  end

  describe '#delete_courses' do
    it "deletes courses" do
      VCR.use_cassette("Commands::Course delete_courses for course #{TEST_DELETE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.delete_courses [{courseid: TEST_DELETE_COURSE_ID}]
        assert response.success?
        course_response = response.dig('response', 'responses', 'response').first
        assert_equal "OK", course_response['code']
      end
    end
  end

  describe '#get_course' do
    it "Gets a courses by id " do
      VCR.use_cassette("Commands::Course get_course for course #{TEST_SOURCE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.get_course courseid: TEST_SOURCE_COURSE_ID
        assert response.success?
        assert_equal "OK", response.dig('response', 'code')
        assert_equal TEST_SOURCE_COURSE_ID.to_s, response.dig('response', 'course', 'id')
      end
    end
  end

  describe '#get_course_history' do
    it "Gets a courses by id " do
      VCR.use_cassette("Commands::Course get_course_history for course #{TEST_SOURCE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.get_course_history courseid: TEST_SOURCE_COURSE_ID
        assert response.success?
        assert_equal "OK", response.dig('response', 'code')
        histories = response.dig('response', 'history', 'course')
        assert histories
        assert_equal TEST_SOURCE_COURSE_ID.to_s, histories.sample['id']
      end
    end
  end

  describe '#list_courses' do
    it "Returns a list of courses by id " do
      VCR.use_cassette("Commands::Course list_courses for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.list_courses domainid: TEST_DOMAIN_ID,  show: 'all'
        assert response.success?
        assert !response.dig('response', 'courses', 'course').empty?
        assert response.dig('response', 'courses', 'course').sample["title"]
      end
    end

    it "Returns a list of all courses" do
      VCR.use_cassette("Commands::Course list_courses all", match_requests_on: [:query]) do
        response = api.list_courses domainid: '0'
        assert response.success?
        assert !response.dig('response', 'courses', 'course').empty?
      end
    end
  end

  describe '#merge_courses' do
    it "Merges a course into its master" do
      VCR.use_cassette("Commands::Course merge_courses for course #{TEST_MERGE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.merge_courses [{courseid: TEST_MERGE_COURSE_ID}]
        assert response.success?
        assert_equal "OK", response.dig('response', 'code')
        assert_equal "OK", response.dig('response', 'responses', 'response').first['code']
      end
    end
  end

  describe '#restore_course' do
    it "restores a course" do
      VCR.use_cassette("Commands::Course restore_course for course #{TEST_DELETE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.restore_course courseid: TEST_DELETE_COURSE_ID
        assert response.success?
        assert_equal "OK", response.dig('response', 'code')
      end
    end
  end

  describe '#update_courses' do
    it "Updates a course" do
      VCR.use_cassette("Commands::Course update_courses for course #{TEST_MERGE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.update_courses [{courseid: TEST_MERGE_COURSE_ID, title: "Updated Course"}]
        assert response.success?
        assert_equal "OK", response.dig('response', 'code')
        assert_equal "OK", response.dig('response', 'responses', 'response').first['code']
      end
    end
  end

end
