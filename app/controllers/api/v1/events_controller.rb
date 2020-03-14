module API::V1
  class EventsController < ApplicationController
    include RegisterEvent

    # Register Github issue event
    # POST /api/v1/event
    def create
      if create_issue_event(params[:event])
        render json: { message: 'Event successfully received' }, status: 200
      else
        render json: { error: 'Invalid event' }, status: 400
      end
    end
  end
end
