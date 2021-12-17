require "./lib/workers/new_registation_worker"
require 'rails_helper'
require 'spec_helper'

RSpec.describe NewRegistrationWorker, type: :worker do
  describe "#perform" do
    subject(:perform) { described_class.new.perform(sqs_message, body) }

    let(:sqs_message) { OpenStruct.new(data: body) }
    let(:body) do
      {
          "name" => Faker::Superhero.name,
          "entities" => [
            "name" => Faker::Superhero.name,
            "users" => [
              {
                "email" => Faker::Internet.email,
                "first_name" => Faker::Name.first_name,
                "last_name" => Faker::Name.last_name,
              },
            ],
          ],
      }
    end

    context "when payload is valid" do
      it "creates a new registration" do
        is_expected.to eql(expected_result)
      end
    end

    context "when payload is invalid" do
      it "raises an error" do
        is_expected.to raise_error((expected_result))
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
