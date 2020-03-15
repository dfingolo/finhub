require 'rails_helper'

RSpec.describe API::V1::IssuesController, type: :controller do
  render_views

  let!(:repository) {
    create(:repository, name: "finhub", username: "dfingolo", token: "0ac163b3-cb76-43e1-96c5-5cbc237d7b73")
  }

  describe "GET /api/v1/issues#index" do
    context "without token in header" do
      it "should respond as unauthorized" do
        get :index

        response_body = {
          "error" => "Invalid token"
        }

        expect(response.content_type).to eq "application/json"
        expect(response.status).to eq(401)
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context "a repository without issues" do
      it "should respond with empty issues array and pagination" do
        request.headers["X-Api-Token"] = repository.token
        get :index, { format: :json }

        response_body = {
          "issues" => [],
          "pagination" => {
            "total" => 0
          }
        }

        expect(response.content_type).to eq "application/json"
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context "a repository with issues" do
      let(:issue) { create(:issue, number: 1, repository: repository) }
      let!(:issue_event) { create(:issue_event, issue: issue) }

      it "should respond with the issues, its events and pagination" do
        request.headers["X-Api-Token"] = repository.token
        get :index, { format: :json }

        response_body = {
          "issues" => [{
            "number" => 1,
            "title" => "Issue 1",
            "state" => "opened",
            "locked" => false,
            "id" => 1,
            "url" => "https://api.github.com/repos/dfingolo/finhub/issues/1",
            "events" => [
              {
                "action" => "opened",
                "issue_changes" => nil,
                "sender" => "dfingolo",
                "created_at" => issue_event.created_at.to_s,
                "updated_at" => issue_event.updated_at.to_s
              }
            ],
            "created_at" => issue.github_created_at.to_s,
            "updated_at" => issue.github_updated_at.to_s,
            "closed_at" => issue.github_closed_at.to_s
          }],
          "pagination" => {
            "total" => 1
          }
        }

        expect(response.content_type).to eq "application/json"
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end
  end

  describe "GET /api/v1/issues/:number#show" do
    context "without token in header" do
      it "should respond as unauthorized" do
        get :show, { params: { number: 1 } }

        response_body = {
          "error" => "Invalid token"
        }

        expect(response.content_type).to eq "application/json"
        expect(response.status).to eq(401)
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context "with nonexistent issue number" do
      it "should respond as not found" do
        request.headers["X-Api-Token"] = repository.token
        get :show, { params: { number: 1 } }

        response_body = {
          "error" => "Issue not found"
        }

        expect(response.content_type).to eq "application/json"
        expect(response.status).to eq(404)
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context "with existent issue number" do
      let(:issue) { create(:issue, number: 1, repository: repository) }
      let!(:issue_event) { create(:issue_event, issue: issue) }

      it "should respond with a issue and its events" do
        request.headers["X-Api-Token"] = repository.token
        get :show, { params: { number: 1 }, format: :json }

        response_body = {
          "number" => 1,
          "title" => "Issue 1",
          "state" => "opened",
          "locked" => false,
          "id" => 1,
          "url" => "https://api.github.com/repos/dfingolo/finhub/issues/1",
          "events" => [
            {
              "action" => "opened",
              "issue_changes" => nil,
              "sender" => "dfingolo",
              "created_at" => issue_event.created_at.to_s,
              "updated_at" => issue_event.updated_at.to_s
            }
          ],
          "created_at" => issue.github_created_at.to_s,
          "updated_at" => issue.github_updated_at.to_s,
          "closed_at" => issue.github_closed_at.to_s
        }

        expect(response.content_type).to eq "application/json"
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end
  end
end
