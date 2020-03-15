require 'rails_helper'

RSpec.describe API::V1::EventsController, type: :controller do
  let!(:repository) {
    create(:repository, name: "finhub", username: "dfingolo", token: "0ac163b3-cb76-43e1-96c5-5cbc237d7b73")
  }

  describe "POST /api/v1/event#create" do
    context "without token in header" do
      it "should respond as unauthorized" do
        post :create, { params: { } }

        response_body = {
          "error" => "Invalid token"
        }

        expect(response.content_type).to eq "application/json"
        expect(response.status).to eq(401)
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context "with invalid params" do
      it "should respond with a error message" do
        request.headers["X-Hub-Signature"] = "sha1=51f54247db298382c62c6dbcfe896b9a29f23d62"
        post :create, {
          params: {
            event: {
              repository: { name: repository.name },
              sender: { login: repository.username }
            }
          }
        }

        response_body = {
          "error" => "Invalid event"
        }

        expect(response.content_type).to eq "application/json"
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context "with valid params" do
      it "should successfully respond" do
        request.headers["X-Hub-Signature"] = "sha1=93ff32332c939ef7b83366bc79a4c942f7c2a3d8"
        post :create, {
          params: {
            event: {
              action: "opened",
              issue: {
                id: 1,
                number: 1,
                title: "Issue 1",
                state: "opened",
                locked: false,
                url: "https://api.github.com/repos/dfingolo/finhub/issues/1",
                user: { id: 1 },
                created_at: DateTime.parse("2020-03-14 11:59:56"),
                updated_at: DateTime.parse("2020-03-14 11:59:56")
              },
              repository: { name: repository.name },
              sender: { login: repository.username }
            }
          }
        }

        response_body = {
          "message" => "Event successfully received"
        }

        expect(response.content_type).to eq "application/json"
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end
  end
end
