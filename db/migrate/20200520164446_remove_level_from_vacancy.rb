class RemoveLevelFromVacancy < ActiveRecord::Migration[6.0]
  def change
    remove_column :vacancies, :level, :string
  end
end
