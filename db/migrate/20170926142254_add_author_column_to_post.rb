class AddAuthorColumnToPost < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :author, index: true, foreign_key: { to_table: :users }
  end
end
