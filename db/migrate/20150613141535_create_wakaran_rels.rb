class CreateWakaranRels < ActiveRecord::Migration

  def change
    create_table :wakaran_rels do |t|
      t.integer :wakararen_post_id
      t.integer :wakaran_user_id
      t.timestamps
    end
    add_index :wakaran_rels, :wakararen_post_id
    add_index :wakaran_rels, :wakaran_user_id
    add_index :wakaran_rels, [:wakararen_post_id, :wakaran_user_id], unique: true
  end
end
