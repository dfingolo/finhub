json.extract! issue, :number, :title, :state, :locked
json.id issue.github_id
json.url issue.github_url

json.events issue.events.each do |event|
  json.extract! event, :action, :issue_changes, :sender
  json.created_at event.created_at.to_s
  json.updated_at event.updated_at.to_s
end

json.created_at issue.github_created_at.to_s
json.updated_at issue.github_updated_at.to_s
json.closed_at issue.github_closed_at.to_s
