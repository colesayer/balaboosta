class AddBodyToNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :content, :string
  end
end
