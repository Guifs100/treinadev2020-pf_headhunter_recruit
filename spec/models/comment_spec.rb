require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'comentário cannot be blank' do
    comment = Comment.new

    comment.valid?

    expect(comment.errors[:text]).to include('Comentário não pode '\
                                                  'ficar em branco')
  end
end
