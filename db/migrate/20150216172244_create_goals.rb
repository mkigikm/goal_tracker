class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id,     null: false
      t.string  :title,       null: false
      t.boolean :public,      null: false
      t.date    :completed_on
      t.date    :due_by
      t.text    :description
      t.text    :progress
    end
    add_index :goals, :user_id
  end
end
