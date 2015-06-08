class CreateWakaruRelations < ActiveRecord::Migration
  def change
    create_table :wakaru_relations do |t|
      t.integer :wakarareru_post_id
      t.integer :wakaru_user_id

      t.timestamps
    end
    add_index :wakaru_relations, :wakarareru_post_id
    add_index :wakaru_relations, :wakaru_user_id
    add_index :wakaru_relations, [:wakarareru_post_id, :wakaru_user_id], unique: true
  end
end
