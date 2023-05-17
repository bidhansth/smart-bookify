require 'rails_helper'

RSpec.describe "bookings/new", type: :view do
  before(:each) do
    assign(:booking, Booking.new(
      user_name: "MyText",
      user_email: "MyText",
      user_contact: 1,
      description: "MyText",
      timeslot_id: 1
    ))
  end

  it "renders new booking form" do
    render

    assert_select "form[action=?][method=?]", bookings_path, "post" do

      assert_select "textarea[name=?]", "booking[user_name]"

      assert_select "textarea[name=?]", "booking[user_email]"

      assert_select "input[name=?]", "booking[user_contact]"

      assert_select "textarea[name=?]", "booking[description]"

      assert_select "input[name=?]", "booking[timeslot_id]"
    end
  end
end
