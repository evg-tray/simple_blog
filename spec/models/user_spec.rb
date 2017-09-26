RSpec.describe User, type: :model do
  describe 'associations' do
    it{ should have_many(:posts).with_foreign_key(:author_id) }
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:username) }
  end
end
