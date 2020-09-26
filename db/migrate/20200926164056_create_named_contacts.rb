class CreateNamedContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :named_contacts do |t|
      t.string :case_id, null: false
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :mobile_number
      t.text :address

      t.timestamps
    end
    add_index :named_contacts, :case_id, unique: true
  end
end
