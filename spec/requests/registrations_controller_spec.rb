RSpec.describe "Api::V1::RegistrationsController", type: :request do
  describe "POST #create" do
    before { post api_v1_registrations_path(params: params) }

    let(:params) do
      {
        account: {
          name: Faker::Superhero.name, from_partner: true,
          entities: [
            {
              name: Faker::Company.name,
              users: [
                {
                  first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name,
                  email: Faker::Internet.email,
                  phone: "(11) 97111-0101",
                },
              ],
            },
          ],
        },
      }
    end

    it "renders 201 success" do
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include({ "id" => "1" })
    end
  end
end
