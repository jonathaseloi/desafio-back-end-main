class NotifyPartner
  def initialize(partner = "internal", message = "new registration")
    @partner = partner
    @message = message
  end

  def perform; end
end
