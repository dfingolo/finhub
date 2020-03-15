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

    protected

    private

    def sent_repository_token
      return if request.headers['X-Hub-Signature'].blank?

      if repository = Repository.find_by(name: params[:event][:repository][:name], username: params[:event][:sender][:login])
        encoded_token = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), repository.token, request.body.read)
        return repository.token if Rack::Utils.secure_compare(encoded_token, request.headers['X-Hub-Signature'])
      end
    end
  end
end
