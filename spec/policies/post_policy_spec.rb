RSpec.describe PostPolicy do

  let(:user) { create(:user) }
  let(:user_author) { create(:user) }
  let(:post) { create(:post, author: user_author)}
  let(:private_post) { create(:post, author: user_author)}
  subject { described_class }

  permissions :show? do
    it 'grants access if post is public' do
      expect(subject).to permit(nil, post)
    end

    it 'grants access if user author of private post' do
      expect(subject).to permit(user_author, post)
    end

    it 'denies access if user not author of private post' do
      expect(subject).to permit(user, private_post)
    end
  end

  permissions :edit? do
    it 'grants access if user author of post' do
      expect(subject).to permit(user_author, post)
    end

    it 'denies access if user not author of post' do
      expect(subject).not_to permit(user, post)
    end
  end

  permissions :update? do
    it 'grants access if user author of post' do
      expect(subject).to permit(user_author, post)
    end

    it 'denies access if user not author of post' do
      expect(subject).not_to permit(user, post)
    end
  end

  permissions :destroy? do
    it 'grants access if user author of post' do
      expect(subject).to permit(user_author, post)
    end

    it 'denies access if user not author of post' do
      expect(subject).not_to permit(user, post)
    end
  end
end
