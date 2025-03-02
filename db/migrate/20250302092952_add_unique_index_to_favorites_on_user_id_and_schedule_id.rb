class AddUniqueIndexToFavoritesOnUserIdAndScheduleId < ActiveRecord::Migration[7.0]
  def change
    add_index :favorites, [:user_id, :schedule_id], unique: true
  end
end
