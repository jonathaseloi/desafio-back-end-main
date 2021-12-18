class NewRegistrationWorker
  include Sidekiq::Worker

  def perform(_, params)
    CreateRegistration.call(params)
  end
end
