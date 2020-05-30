class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.date :start_date
      t.decimal :salary
      t.string :benefits
      t.string :job_functions
      t.references :headhunter, null: false, foreign_key: true
      t.references :apply_vacancy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
