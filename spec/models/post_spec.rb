RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(10).is_at_most(200) }
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(30) }
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments).dependent(:destroy) }
  end
end
