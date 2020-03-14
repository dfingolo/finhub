module RegisterWebhook
  include ActiveSupport::Concern

  def create_issue_event(webhook)
    return if webhook[:issue].blank?

    if issue = create_or_update_issue(webhook[:issue])
      event = IssueEvent.new(
        issue: issue,
        action: webhook[:action],
        issue_changes: webhook[:changes],
        sender: webhook[:sender][:login]
      )

      event.save
    end
  end

  def create_or_update_issue(issue_params)
    issue = Issue.find_or_initialize_by(github_id: issue_params[:id])

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
