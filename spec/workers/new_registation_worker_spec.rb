require "./lib/workers/new_registation_worker"
require 'rails_helper'
require 'spec_helper'

RSpec.describe NewRegistrationWorker, type: :worker do
  describe "#perform" do
    subject(:perform) { described_class.new.perform(sqs_message, body.to_h) }

    let(:sqs_message) { OpenStruct.new(data: body.to_h) }

    context "when payload is valid" do
      let(:body) do
        {
          name: Faker::Superhero.name,
          entities: [
            {
              name: Faker::Company.name,
              users: [
                {
                  first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name,
                  email: Faker::Internet.email,
                  phone: "(11) 97111-0101",
                },
              ],
            },
          ],
        }
      end
      let(:expected_result) {ApplicationService::Result.new(true, Account.last, nil) }

      it "creates a new registration" do
        is_expected.to eql(expected_result)
      end
    end

    context "when payload is invalid" do
      let(:body) do
        {
          name: Faker::Superhero.name,
          entities: [
            {
              name: "",
              users: [
                {
                  first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name,
                  email: Faker::Internet.email,
                  phone: "(11) 97111-0101",
                },
              ],
            },
          ],
        }
      end
    end
  end

  context "queue" do 
    it "job in correct queue" do 
      described_class.perform_async
      assert_equal "default", described_class.queue
    end
  end
end
