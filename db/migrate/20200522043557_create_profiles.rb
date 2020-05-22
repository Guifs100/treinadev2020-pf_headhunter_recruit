class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.string :social_name
      t.date :birth_date
      t.string :formation
      t.string :description
      t.string :experience
      t.references :candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
