class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :caption
      t.string :post_photo
      t.integer :user_id
    end
  end
end
