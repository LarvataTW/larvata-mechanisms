class CreateLarvataMechanismsFuncs < ActiveRecord::Migration[6.0]
  def change
    create_table :funcs do |t|
      t.string :name
      t.string :desc
      t.string :ancestry

      t.timestamps
    end
    add_index :funcs, :name
    add_index :funcs, :ancestry
  end
end
