require 'rails_helper'

RSpec.describe "bookings/index", type: :view do
  before(:each) do
    assign(:bookings, [
      Booking.create!(
        user_name: "MyText",
        user_email: "MyText",
        user_contact: 2,
        description: "MyText",
        timeslot_id: 3
      ),
      Booking.create!(
        user_name: "MyText",
        user_email: "MyText",
        user_contact: 2,
        description: "MyText",
        timeslot_id: 3
      )
    ])
  end

  it "renders a list of bookings" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
