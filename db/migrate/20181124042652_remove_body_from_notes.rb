class RemoveBodyFromNotes < ActiveRecord::Migration[5.1]
  def change
    remove_column :notes, :body, :text
  end
end
