class NewRegistrationWorker
  include Sidekiq::Worker

  def perform(sqs, params)
    CreateRegistration.call(params)
  end
end
