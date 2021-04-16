class CreateLarvataMechanismsAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.bigint :attachable_id
      t.string :attachable_type
      t.text :file_data

      t.timestamps
    end
    add_index :attachments, [:attachable_id, :attachable_type]
  end
end
