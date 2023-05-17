require 'rails_helper'

RSpec.describe "bookings/show", type: :view do
  before(:each) do
    assign(:booking, Booking.create!(
      user_name: "MyText",
      user_email: "MyText",
      user_contact: 2,
      description: "MyText",
      timeslot_id: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/3/)
  end
end
