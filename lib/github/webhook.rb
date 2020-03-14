module Github
  class Webhook < Base
    def create(repository)
      post("/repos/#{username}/#{repository.name}/hooks", {
        name: "web",
        active: true,
        events: ["issues"],
        config: {
          url: "#{ENV['HOST']}/api/v1/event",
          secret: repository.token,
          content_type: "json",
          insecure_ssl: "0"
        }
      })
    end
  end
end
