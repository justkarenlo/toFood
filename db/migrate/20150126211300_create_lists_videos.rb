class CreateListsVideos < ActiveRecord::Migration

  def change
    create_table :lists_videos do |t|
      t.belongs_to :list, index: true
      t.belongs_to :video, index: true
    end
  end

end