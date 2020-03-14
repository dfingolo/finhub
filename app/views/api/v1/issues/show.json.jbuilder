json.extract! @issue, :number, :title, :state, :locked

["github_id", "github_url", "github_created_at", "github_updated_at", "github_closed_at"].each do |key|
  hash = {}
  hash[key.gsub("github_", "")] = @issue.send(key)
  json.merge! hash
end

json.events @issue.events.each do |event|
  json.extract! event, :action, :issue_changes, :sender, :created_at, :updated_at
end
