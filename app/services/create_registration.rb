class CreateRegistration < ApplicationService
  def initialize(payload)
    @payload = payload
  end

  def call
    @result = if @payload[:from_partner] && @payload[:many_partners]
                create_account_and_notify_partners
              elsif @payload[:from_partner]
                create_account_and_notify_partner
              else
                create_account
              end
    
    return Result.new(true, @result.body) if @result.success?

    @result
  end

  private

  def create_account_and_notify_partner
    CreateAccountAndNotifyPartner.call(@payload)
  end

  def create_account_and_notify_partners
    CreateAccountAndNotifyPartners.call(@payload)
  end

  def create_account
    from_fintera = @payload[:name].include?("Fintera") && fintera_users(@payload)
    CreateAccount.call(@payload, from_fintera)
  end

  def fintera_users(payload)
    with_fintera_user = false

    payload[:users].each do |user|
      if user[:email].include? "fintera.com.br"
        with_fintera_user = true
        break
      end
    end

    with_fintera_user
  end
end
