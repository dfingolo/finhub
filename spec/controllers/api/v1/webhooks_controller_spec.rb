require 'rails_helper'

RSpec.describe API::V1::WebhooksController, type: :controller do
  describe "POST /api/v1/webhook#create" do
    context "with invalid params" do
      it "should respond with a error message" do
        post :create, { params: {} }

        response_body = {
          "error" => "Invalid parameters"
        }

        expect(response.content_type).to eq "application/json"
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context "with invalid password" do
      it "should respond as unauthorized" do
        VCR.use_cassette("github/configure_webhook_with_invalid_password") do
          post :create, {
            params: {
              username: "dfingolo",
              password: "123",
              repository: "finhub"
            }
          }

          response_body = {
            "message" => "Bad credentials",
            "documentation_url" => "https://developer.github.com/v3"
          }

          expect(response.content_type).to eq "application/json"
          expect(response.status).to eq(401)
          expect(JSON.parse(response.body)).to eq(response_body)
        end
      end
    end

    context "with valid params" do
      let!(:repository) {
        create(:repository, name: "finhub", username: "dfingolo", token: "0ac163b3-cb76-43e1-96c5-5cbc237d7b73")
      }

      it "should successfully respond" do
        VCR.use_cassette("github/configure_successfully_webhook") do
          post :create, {
            params: {
              username: "dfingolo",
              password: "12345",
              repository: "finhub"
            }
          }

          response_body = {
            "message" => "Webhook successfully configured",
            "token" => "0ac163b3-cb76-43e1-96c5-5cbc237d7b73"
          }

          expect(response.content_type).to eq "application/json"
          expect(response.status).to eq(201)
          expect(JSON.parse(response.body)).to eq(response_body)
        end
      end
    end

    context "Webhook already exists" do
      let!(:repository) {
        create(:repository, name: "finhub", username: "dfingolo", token: "0ac163b3-cb76-43e1-96c5-5cbc237d7b73")
      }

      it "should respond with a error message" do
        VCR.use_cassette("github/configure_existing_webhook") do
          post :create, {
            params: {
              username: "dfingolo",
              password: "12345",
              repository: "finhub"
            }
          }

          response_body = {
            "message" => "Validation Failed",
            "errors" => [
              {
                "resource" => "Hook",
                "code" => "custom",
                "message" => "Hook already exists on this repository"
              }
            ],
            "documentation_url" => "https://developer.github.com/v3/repos/hooks/#create-a-hook"
          }

          expect(response.content_type).to eq "application/json"
          expect(response.status).to eq(422)
          expect(JSON.parse(response.body)).to eq(response_body)
        end
      end
    end
  end
end
