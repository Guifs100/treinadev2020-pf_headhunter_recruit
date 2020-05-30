class AddAnswerToProposal < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :answer, :string
  end
end
