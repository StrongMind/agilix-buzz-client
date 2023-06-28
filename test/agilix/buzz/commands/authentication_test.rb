require "test_helper"

class Agilix::Buzz::Commands::AuthenticationTest < Minitest::Test

  describe "#login2" do
    it "logs in a user" do
      skip "skip for now"
      VCR.use_cassette("Commands::Authentication login", match_requests_on: [:query]) do
        username = ENV.fetch("AGILIX_BUZZ_USERNAME", 'your-username')
        password = ENV.fetch("AGILIX_BUZZ_PASSWORD", 'your-password')
        domain   = ENV.fetch("AGILIX_BUZZ_DEFAULT_DOMAIN", 'your-domain')
        response = api.login username: username, password: password, domain: domain
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        assert_equal username, response.dig("response", "user", "username")
        assert_equal domain, response.dig("response", "user", "userspace")
        assert response.dig("response", "user", "token")
      end
    end
  end

  describe "#logout" do
    it "logs out a user" do
      skip "skip for now"
      VCR.use_cassette("Commands::Authentication logout", match_requests_on: [:query]) do
        api.check_authentication
        assert api.token
        assert api.token_expiration
        response = api.logout
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        refute api.token
        refute api.token_expiration
      end
    end
  end

  describe "#extend_session" do
    it "extends the token expiration on a users session" do
      VCR.use_cassette("Commands::Authentication extend_session", match_requests_on: [:query]) do
        api.check_authentication
        assert exp1 = api.token_expiration
        response = api.extend_session
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        refute_equal exp1, api.token_expiration
      end
    end
  end

  describe "#force_password_change" do
    it "forces a user to change their password" do
      VCR.use_cassette("Commands::Authentication force_password_change #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.force_password_change userid: TEST_USER_ID
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#get_password_login_attempt_history" do
    it "shows login attempt history for a user" do
      VCR.use_cassette("Commands::Authentication get_password_login_attempt_history #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.get_password_login_attempt_history userid: TEST_USER_ID, earliestrecordtoreturn: '2018-01-01'
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        attempts = response.dig("response", "passwordloginattemptrecords", "passwordloginattemptrecord")
        assert_kind_of Array, attempts
        assert_equal TEST_USER_ID.to_i, attempts.sample["userid"] if attempts.any?
      end
    end
  end

  describe "#get_password_policy" do
    it "looks up a password policy for a domain" do
      VCR.use_cassette("Commands::Authentication get_password_policy #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.get_password_policy domainid: TEST_DOMAIN_ID
        assert response.success?
        policy = response.dig("response", "passwordpolicy")
        assert_kind_of Hash, policy
        assert_equal 9, policy["minimumlength"]
      end
    end
  end

  describe "#get_password_question" do
    it "looks up a password question for a user" do
      VCR.use_cassette("Commands::Authentication update_password_question_answer #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.get_password_question username: "auto-tests/BuzzUserUp1"
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        assert_equal "Where is your favorite vacation place?", response.dig("response", "question", "$value")
      end
    end
  end

  describe "#update_password_question_answer" do
    it "updates a password question/answer for a user" do
      VCR.use_cassette("Commands::Authentication update_password_question_answer #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.update_password_question_answer userid: TEST_USER_ID, passwordquestion: "Where is your favorite vacation place?", passwordanswer: "Hawaii"
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end


  describe "#proxy" do
    it "gets proxy login info for a user" do
      VCR.use_cassette("Commands::Authentication proxy #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.proxy userid: TEST_USER_ID
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        assert_equal TEST_USER_ID, response.dig("response", "user", "userid")
      end
    end
  end

  describe "#proxy_api" do
    it "starts a proxy api session for a user" do
      VCR.use_cassette("Commands::Authentication proxy_api #{TEST_USER_ID}", match_requests_on: [:query]) do
        proxy_api = api.proxy_api userid: TEST_USER_ID
        assert proxy_api.token
        assert proxy_api.token_expiration
      end
    end
  end

  describe "#proxy_sso_link" do
    it "starts a proxy api session for a user" do
      VCR.use_cassette("Commands::Authentication proxy_sso_link #{TEST_USER_ID}", match_requests_on: [:query]) do
        proxy_sso_link = api.proxy_sso_link userid: TEST_USER_ID
        assert proxy_sso_link
      end
    end
    it "starts a proxy api session for a user with custom path" do
      VCR.use_cassette("Commands::Authentication proxy_sso_link #{TEST_USER_ID} with custom path", match_requests_on: [:query]) do
        path = "student/home/courses"
        proxy_sso_link = api.proxy_sso_link userid: TEST_USER_ID, redirect_url: path
        assert proxy_sso_link
        assert_includes proxy_sso_link, "url=/#{path}"
      end
    end
  end

  describe "#unproxy" do
    it "does not unproxy a user if they aren't using current api" do
      VCR.use_cassette("Commands::Authentication unproxy fail #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.unproxy userid: TEST_USER_ID
        assert response.success?
        assert_equal "BadRequest", response.dig("response", "code")
      end
    end

    it "successfully unproxies a proxied user" do
      VCR.use_cassette("Commands::Authentication unproxy #{TEST_USER_ID}", match_requests_on: [:query]) do
        proxy_api = api.proxy_api userid: TEST_USER_ID
        response = proxy_api.unproxy userid: TEST_USER_ID
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        refute_equal TEST_USER_ID, response.dig("response", "user", "userid")
        assert_equal ENV.fetch("AGILIX_BUZZ_USERNAME", 'your-username'), response.dig("response", "user", "username")
      end
    end
  end


  describe "#reset_lockout" do
    it "resets an account lockout for a user" do
      VCR.use_cassette("Commands::Authentication reset_lockout #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.reset_lockout userid: TEST_USER_ID
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#reset_password" do
    it "triggers a reset password email for a user" do
      VCR.use_cassette("Commands::Authentication reset_password #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.reset_password username: 'auto-tests/BuzzUserUp1'
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#update_password" do
    it "updates a password for a user" do
      VCR.use_cassette("Commands::Authentication update_password #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.update_password userid: 57181, password: "IChanged123"
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#put_key" do
    it "stores a key value secret on a domain" do
      VCR.use_cassette("Commands::Authentication put_key secret_key_1", match_requests_on: [:query]) do
        response = api.put_key entityid: TEST_DOMAIN_ID, name: "secret_key_1", value: "Super Secret"
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#get_key" do
    it "retrieves a key value secret from a domain" do
      VCR.use_cassette("Commands::Authentication get_key secret_key_1", match_requests_on: [:query]) do
        response = api.get_key entityid: TEST_DOMAIN_ID, name: "secret_key_1"
        assert response.success?
        assert_equal "Super Secret", response.dig("response", "key", "value")
      end
    end
  end

  describe "#compute_hmac" do
    it "generates HMAC for a stored key/value message" do
      VCR.use_cassette("Commands::Authentication compute_hmac secret_key_1", match_requests_on: [:query]) do
        response = api.compute_hmac domainid: TEST_DOMAIN_ID, keyname: "secret_key_1", message:"my-secret-1"
        assert response.success?
        assert_includes response.dig("response", "hmac").keys, "hmac"
      end
    end
  end






end
