module API::V1
  class WebhooksController < ApplicationController
    include RegisterWebhook

    # Register Github issue event
    # POST /api/v1/webhook
    def create
      if create_issue_event(params[:webhook])
        render json: { message: 'Event successfully received' }, status: 200
      else
        render json: { error: 'Invalid event' }, status: 400
      end
    end
  end
end
