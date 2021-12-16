RSpec.describe Account do
  describe "associations" do
    it { is_expected.to have_many :entities }
  end

  describe "presence of name" do
    it { should validate_presence_of(:name) }
  end
end
