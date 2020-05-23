class AddHeadhunterToVacancy < ActiveRecord::Migration[6.0]
  def change
    add_reference :vacancies, :headhunter, null: false, foreign_key: true
  end
end
