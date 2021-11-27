require 'rails_helper'

RSpec.describe "organisations/index", type: :view do
  before(:each) do
    assign(:organisations, [
      Organisation.create!(
        name: "Name",
        hourly_rate: "9.99"
      ),
      Organisation.create!(
        name: "Name",
        hourly_rate: "9.99"
      )
    ])
  end

  it "renders a list of organisations" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
  end
end
