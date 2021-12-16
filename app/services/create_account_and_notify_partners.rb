class CreateAccountAndNotifyPartners < ApplicationService
  def initialize(data)
    @params = data
  end

  def call
    CreateAccountAndNotifyPartner.call(@params)
    NotifyPartner.new("Another").perform
  end
end
