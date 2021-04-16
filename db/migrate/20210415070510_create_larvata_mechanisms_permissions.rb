class CreateLarvataMechanismsPermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.references :role, null: true
      t.references :func, null: true
    end

    add_foreign_key :permissions, :roles, column: :role_id
    add_foreign_key :permissions, :funcs, column: :func_id
  end
end
