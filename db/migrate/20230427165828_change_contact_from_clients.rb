class ChangeContactFromClients < ActiveRecord::Migration[7.0]
  def change
    change_column(:clients, :contact_no, :integer)
  end
end
