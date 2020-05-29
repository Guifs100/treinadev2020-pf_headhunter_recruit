class CreateRejectApplyVacancies < ActiveRecord::Migration[6.0]
  def change
    create_table :reject_apply_vacancies do |t|
      t.string :feedback
      t.references :headhunter, null: false, foreign_key: true
      t.references :apply_vacancy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
