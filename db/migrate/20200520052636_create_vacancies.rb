class CreateVacancies < ActiveRecord::Migration[6.0]
  def change
    create_table :vacancies do |t|
      t.string :title
      t.string :job_description
      t.string :skills
      t.decimal :salary
      t.integer :level
      t.date :registration_date
      t.string :address

      t.timestamps
    end
  end
end
