json.issues @issues do |issue|
  json.partial! issue
end

json.pagination do
  json.total @issues.total_entries
  json.previous_page url_for(request.GET.merge(page: @issues.previous_page)) if @issues.previous_page
  json.next_page url_for(request.GET.merge(page: @issues.next_page)) if @issues.next_page
end
