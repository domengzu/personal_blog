class AddUniqueIndexToReactions < ActiveRecord::Migration[8.1]
  def change
    add_index :reactions, [ :user_id, :post_id ], unique: true
  end
end
