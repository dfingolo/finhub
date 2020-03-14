module RegisterWebhook
  include ActiveSupport::Concern

  def configure_webhook(password)
    response = Github::Webhook.new(username: @repository.username, password: password).create(@repository.reload)

    body = if response.code == 201
      {
        message: 'Webhook successfully configured',
        token: @repository.token
      }
    else
      response.body
    end

    { body: body, status: response.code }
  end
end
