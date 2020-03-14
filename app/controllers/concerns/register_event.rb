module RegisterEvent
  include ActiveSupport::Concern

  def create_issue_event(event_params)
    return if event_params[:issue].blank?

    repository = Repository.find_or_create_by(
      username: event_params[:repository][:owner][:login],
      name: event_params[:repository][:name]
    )

    if issue = create_or_update_issue(repository, event_params[:issue])
      event = IssueEvent.new(
        issue: issue,
        action: event_params[:action],
        issue_changes: event_params[:changes],
        sender: event_params[:sender][:login]
      )

      event.save
    end
  end

  def create_or_update_issue(repository, issue_params)
    issue = repository.issues.find_or_initialize_by(github_id: issue_params[:id])

    issue.number = issue_params[:number]
    issue.title = issue_params[:title]
    issue.state = issue_params[:state]
    issue.locked = issue_params[:locked]
    issue.github_user_id = issue_params[:user][:id]
    issue.github_url = issue_params[:url]
    issue.github_created_at = issue_params[:created_at]
    issue.github_updated_at = issue_params[:updated_at]
    issue.github_closed_at = issue_params[:closed_at]

    issue if issue.save
  end
end
