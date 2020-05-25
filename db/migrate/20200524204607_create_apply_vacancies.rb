class CreateApplyVacancies < ActiveRecord::Migration[6.0]
  def change
    create_table :apply_vacancies do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :vacancy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
