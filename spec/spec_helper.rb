require "webmock/rspec"

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:post, "https://61b69749c95dd70017d40f4b.mockapi.io/awesome_partner_leads").
         with(
           body: {"message"=>"new registration", "partner"=>"internal"},
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>'Faraday v1.8.0'
           }).
         to_return(status: 201, body: { "id" => "1" }.to_json, headers: {})
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
