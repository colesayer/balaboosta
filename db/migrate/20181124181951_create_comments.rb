class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content
      t.boolean :is_important, default: false, null: false
      t.references :noteable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
