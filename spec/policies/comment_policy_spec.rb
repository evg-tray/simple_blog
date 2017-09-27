RSpec.describe CommentPolicy do

  let(:user) { create(:user) }
  let(:user_author) { create(:user) }
  let(:comment) { create(:comment, author: user_author) }
  let(:old_comment) { create(:comment, author: user_author) }

  subject { described_class }

  before { old_comment.created_at = old_comment.created_at - 15.minutes }

  permissions :edit? do
    it 'grants access if user author of comment' do
      expect(subject).to permit(user_author, comment)
    end

    it 'denies access if user not author of comment' do
      expect(subject).not_to permit(user, comment)
    end

    it 'denies access if comment created less than 15 minutes ago ' do
      expect(subject).not_to permit(user_author, old_comment)
    end
  end

  permissions :update? do
    it 'grants access if user author of comment' do
      expect(subject).to permit(user_author, comment)
    end

    it 'denies access if user not author of comment' do
      expect(subject).not_to permit(user, comment)
    end

    it 'denies access if comment created less than 15 minutes ago ' do
      expect(subject).not_to permit(user_author, old_comment)
    end
  end

  permissions :destroy? do
    it 'grants access if user author of comment' do
      expect(subject).to permit(user_author, comment)
    end

    it 'denies access if user not author of comment' do
      expect(subject).not_to permit(user, comment)
    end

    it 'denies access if comment created less than 15 minutes ago ' do
      expect(subject).not_to permit(user_author, old_comment)
    end
  end
end
