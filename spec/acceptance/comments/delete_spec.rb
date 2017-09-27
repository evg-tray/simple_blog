require_relative '../acceptance_helper'

feature 'Delete comments', %q{
  In order to be able to delete incorrect comments
  As a user
  I want to be able delete comments
} do

  given!(:user_author) { create(:user) }
  given!(:user) { create(:user) }
  given!(:post) { create(:post) }
  given!(:comment) { create(:comment, post: post, author: user_author) }
  given!(:post_with_old_comment) { create(:post) }
  given!(:old_comment) { create(:comment, post: post_with_old_comment) }

  before { old_comment.created_at = old_comment.created_at - 15.minutes }

  scenario 'author delete new comment' do
    sign_in(user_author)
    visit post_path(post)

    click_on t('posts.comment.delete_comment')

    expect(page).not_to have_content comment.text
    expect(current_path).to eq post_path(post)
  end

  scenario 'author tries delete old comment' do
    sign_in(user_author)
    visit post_path(post_with_old_comment)

    expect(page).not_to have_link t('posts.comment.delete_comment')
  end

  scenario 'user tries delete coment another user' do
    sign_in(user)
    visit post_path(post)

    expect(page).not_to have_link t('posts.comment.delete_comment')
  end

  scenario 'Non-authenticated user tries delete comment' do
    visit post_path(post)

    expect(page).not_to have_link t('posts.comment.delete_comment')
  end
end
