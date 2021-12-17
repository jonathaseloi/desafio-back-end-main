class CreateAccountAndNotifyPartners < ApplicationService
  def initialize(data, from_fintera)
    @params = data
    @from_fintera = from_fintera
  end

  def call
    CreateAccountAndNotifyPartner.call(@params, @from_fintera)
    NotifyPartner.new("Another").perform
  end
end
