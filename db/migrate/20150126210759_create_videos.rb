class CreateVideos < ActiveRecord::Migration

  def change
    create_table :videos do |t|
      t.string :title
      t.string :unique_id
    end
  end

end