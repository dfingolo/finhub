module API::V1
  class WebhooksController < ApplicationController
    include RegisterWebhook

    # Register issue webhook in Github
    # POST /api/v1/webhook username:string password:string repository:string
    def create
      if @repository = Repository.find_or_create_by(username: params[:username], name: params[:repository])
        response = configure_webhook(params[:password])
        render json: response[:body], status: response[:status]
      else
        render json: { error: 'Invalid parameters' }, status: 400
      end
    end
  end
end
