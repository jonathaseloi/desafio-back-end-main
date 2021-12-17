class NewRegistrationWorker
  include Sidekiq::Worker

  def perform(sqs, params)
    begin
      CreateRegistration.call(params)
    rescue StandardError => e
      Rails.logger.warn("error: #{e}")
      raise e
    end
  end
end
