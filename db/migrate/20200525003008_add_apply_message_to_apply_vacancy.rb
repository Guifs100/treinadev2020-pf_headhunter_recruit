class AddApplyMessageToApplyVacancy < ActiveRecord::Migration[6.0]
  def change
    add_column :apply_vacancies, :apply_message, :string
  end
end
