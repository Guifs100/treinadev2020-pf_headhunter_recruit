class CreateStarProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :star_profiles do |t|
      t.integer :status, default: 0
      t.references :headhunter, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
