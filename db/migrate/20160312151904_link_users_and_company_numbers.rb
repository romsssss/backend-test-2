class LinkUsersAndCompanyNumbers < ActiveRecord::Migration
  def change
    create_table :company_numbers_users, id: false do |t|
      t.belongs_to :company_number, index: true
      t.belongs_to :user, index: true
    end
  end
end
