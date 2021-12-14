class CreateAccount < ApplicationService
  def initialize(payload, from_fintera = false)
    @payload = payload
    @from_fintera = from_fintera
    @errors = []
  end

  def call
    if account_valid?
      account = Account.new(account_params)
      return Result.new(true, account) if account.save && User.insert_all(users_params(account))      
      @errors << account.errors.full_messages
    else
      @errors << "Account is not valid"
    end
    Result.new(false, nil, @errors.join(","))
  end

  def account_valid?
    @payload.present?
  end

  def account_params
    {
      name: @payload[:name],
      active: @from_fintera,
    }
  end

  def users_params(account)
    @payload[:users].map do |user|
      {
        first_name: user[:first_name],
        last_name: user[:last_name],
        email: user[:email],
        phone: user[:phone].to_s.gsub(/\D/, ""),
        account_id: account.id,
        created_at: Time.zone.now,
        updated_at: Time.zone.now,
      }
    end
  end
end
