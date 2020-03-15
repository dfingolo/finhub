class ApplicationController < ActionController::API
  before_action :autenticate_repository!

  protected

  private

  def autenticate_repository!
    if current_repository.nil?
      render(json: { error: 'Invalid token' }, status: :unauthorized) && return
    end
  end

  def current_repository
    @current_repository ||= locate_repository if sent_repository_token.present?
  end

  def locate_repository
    Repository.find_by(token: sent_repository_token)
  end

  def sent_repository_token
    request.headers['X-Api-Token']
  end
end
