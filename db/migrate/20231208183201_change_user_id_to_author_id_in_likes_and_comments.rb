class ChangeUserIdToAuthorIdInLikesAndComments < ActiveRecord::Migration[6.0]
  def change
    rename_column :likes, :user_id, :author_id
    rename_column :comments, :user_id, :author_id
  end
end