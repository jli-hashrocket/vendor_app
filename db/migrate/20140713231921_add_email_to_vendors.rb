class AddEmailToVendors < ActiveRecord::Migration
  def up
    add_column :vendors, :email, :string
  end

  def down
    remove_column :vendors, :email
  end
end
