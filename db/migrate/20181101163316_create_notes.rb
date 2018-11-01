class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.text :body
      t.boolean :is_important, null: false, default: false

      t.timestamps
    end
  end
end
