class CreateLists < ActiveRecord::Migration

  def change
    create_table :lists do |t|
      t.string :name, default: "Today"
      t.integer :user_id
    end
  end

end