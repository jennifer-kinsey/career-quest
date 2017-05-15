class UpdateForeignKeys < ActiveRecord::Migration[5.1]
  def change
    remove_column :companies, :contact_id, :uuid
    add_column :contacts, :company_id, :uuid
    add_column :user_credentials, :user_detail_id, :uuid
    add_column :user_details, :user_credential_id, :uuid
  end
end
