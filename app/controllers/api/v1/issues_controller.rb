module API::V1
  class IssuesController < ApplicationController
    # Search issue by number
    # GET /api/v1/issues/:number
    def show
      @issue = current_repository.issues.find_by(number: params[:number])

      if @issue.blank?
        render json: { error: 'Issue not found' }, status: :not_found
      end
    end
  end
end
