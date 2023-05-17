require 'rails_helper'

RSpec.describe "bookings/edit", type: :view do
  let(:booking) {
    Booking.create!(
      user_name: "MyText",
      user_email: "MyText",
      user_contact: 1,
      description: "MyText",
      timeslot_id: 1
    )
  }

  before(:each) do
    assign(:booking, booking)
  end

  it "renders the edit booking form" do
    render

    assert_select "form[action=?][method=?]", booking_path(booking), "post" do

      assert_select "textarea[name=?]", "booking[user_name]"

      assert_select "textarea[name=?]", "booking[user_email]"

      assert_select "input[name=?]", "booking[user_contact]"

      assert_select "textarea[name=?]", "booking[description]"

      assert_select "input[name=?]", "booking[timeslot_id]"
    end
  end
end
