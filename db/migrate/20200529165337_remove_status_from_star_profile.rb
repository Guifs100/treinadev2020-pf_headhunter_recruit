class RemoveStatusFromStarProfile < ActiveRecord::Migration[6.0]
  def change
    remove_column :star_profiles, :status, :integer
  end
end
