module API::V1
  class IssuesController < ApplicationController
    # Search issue by number
    # GET /api/v1/issues/:number
    def show
      @issue = current_repository.issues.find_by(number: params[:number])

      head :not_found if @issue.blank?
    end
  end
end
