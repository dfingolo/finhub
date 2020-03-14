module Github
  class Base
    attr_accessor :username, :password

    def initialize(username:, password:)
      self.username = username
      self.password = password
    end

    def post(path, body)
      HTTParty.post(
        "https://api.github.com#{path}",
        :basic_auth => basic_auth,
        :headers    => headers,
        :body       => body.to_json
      )
    end

    private

    def basic_auth
      {
        :username => username,
        :password => password
      }
    end

    def headers
      {
        'Content-Type' => 'application/json'
      }
    end
  end
end
