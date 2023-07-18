module Agilix
  module Buzz
    class Api
      include HTTParty

      include Agilix::Buzz::Commands::Authentication
      include Agilix::Buzz::Commands::Course
      include Agilix::Buzz::Commands::Domain
      include Agilix::Buzz::Commands::Enrollment
      include Agilix::Buzz::Commands::General
      include Agilix::Buzz::Commands::Library
      include Agilix::Buzz::Commands::Manifest
      include Agilix::Buzz::Commands::Report
      include Agilix::Buzz::Commands::Resource
      include Agilix::Buzz::Commands::Right
      include Agilix::Buzz::Commands::User

      attr_accessor :username, :password, :domain, :token, :token_expiration, :agilix_url_endpoint

      def initialize(options = {})
        @username = options.fetch(:username, default_username)
        @password = options.fetch(:password, default_password)
        @domain = options.fetch(:domain, default_domain)
        @token = options.dig(:token)
        @token_expiration = options.dig(:token_expiration)
        @agilix_url_endpoint = options.fetch(:agilix_url_endpoint, default_agilix_url_endpoint)
      end

      def authenticated_get(query = {})
        check_authentication
        get query
      end

      def authenticated_post(query = {})
        check_authentication unless query.delete(:bypass_authentication_check)
        post query
      end

      def authenticated_query_post(query = {})
        check_authentication unless query.delete(:bypass_authentication_check)
        query_post query
      end

      def authenticated_bulk_post(query = {})
        check_authentication
        bulk_post query
      end

      def get(query = {})
        response = self.class.get(agilix_url_base, query: modify_query(query), timeout: 60, headers: headers)
      end

      def post(query = {})
        response = self.class.post(agilix_url_base, body: modify_body(query), timeout: 60, headers: headers)
      end

      # Not sure if I want to use this yet
      # api.response_parser response: response, path_to_parse: ['response', 'users', 'user'], collection_name: 'users'
      # def response_parser(path_to_parse: nil, collection_name: nil, response: )
      #   if path_to_parse
      #     result = response.dig(*path_to_parse)
      #     ostruct = JSON::parse({collection_name => result}.to_json, object_class: OpenStruct)
      #     ostruct.result_count = result.size
      #     ostruct.collection_name = collection_name
      #   else
      #     ostruct = JSON::parse(response.body, object_class: OpenStruct)
      #   end
      #   ostruct.code = response['code']
      #   ostruct.response = response
      #   ostruct.request = request
      #   ostruct
      # end

      # For when the api is super unconventional & you need to modify both query params & body params in a custom fashion, and upload a file even!
      def query_post(query = {})
        url = agilix_url_base
        query_params = query.delete(:query_params)
        if query_params
          url += "?&_token=#{token}" + query_params.map {|k,v| "&#{k}=#{v}" }.join("")
        end
        file = query.delete(:file)
        if file
          new_headers = headers
          new_headers["Content-Type"] = "multipart/form-data"
          response = self.class.post(url, multipart: true, body: {file: file}, timeout: 60, headers: new_headers)
        else
          response = self.class.post(url, body: query.to_json, timeout: 60, headers: headers)
        end
      end

      def bulk_post(query = {})
        cmd = query.delete(:cmd)
        url = agilix_url_base + "?cmd=#{cmd}&_token=#{token}"
        query_params = query.delete(:query_params)
        if query_params
          url += query_params.map {|k,v| "&#{k}=#{v}" }.join("")
        end
        response = self.class.post(url, body: modify_bulk_body(query), timeout: 60, headers: headers)
      end

      def check_authentication
        if token && token_expiration
          if token_expiration < Time.now
            extend_session
          end
        else
          authenticate!
        end
      end

      private

      def authenticate!
        response = login username: @username, password: @password, domain: @domain
        raise AuthenticationError.new(response.dig("response", "message")) if response.dig("response", "code") == "InvalidCredentials"
        @token = response.dig("response", "user", "token")
        @token_expiration = Time.now + (response.dig("response", "user", "authenticationexpirationminutes").to_i * 60 ) if @token
        response
      end

      def argument_cleaner(required_params: , optional_params: , options: )
        missing_required = required_params - options.map {|k,v| k.to_sym }
        raise ArgumentError.new("Missing Required Arguments: #{missing_required.join(', ')}") if missing_required.any?
        all_params = (required_params + optional_params).flatten
        return options.select {|k,v| all_params.include?(k.to_sym)}
      end

      def modify_query(query = {})
        default_params = {}
        default_params.merge! query
        default_params["_token"] =  token if token
        default_params
      end

      def modify_body(body = {})
        default_params = { request: {}.merge(body) }
        default_params[:request]["_token"] = token if token
        default_params.to_json
      end

      def modify_bulk_body(query = {})
        root_node = query.delete(:root_node)
        default_params = { requests: { root_node.to_sym => query[:body] } }
        default_params.to_json
      end

      def headers
        @headers = {
          "Accept" => "application/json",
          "Content-Type" => "application/json",
        }
      end

      def default_username
        ENV["AGILIX_BUZZ_USERNAME"]
      end

      def default_password
        ENV["AGILIX_BUZZ_PASSWORD"]
      end

      def default_domain
        ENV["AGILIX_BUZZ_DEFAULT_DOMAIN"]
      end

      def default_agilix_url_endpoint
        ENV.fetch("AGILIX_BUZZ_URL", "https://api.agilixbuzz.com")
      end

      def agilix_url_base
        @agilix_url_base ||= "#{agilix_url_endpoint}/cmd"
      end

    end
  end
end
