class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :name
      t.binary :data
      t.string :filename
      t.string :mime_type
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
