require_relative '../acceptance_helper'

feature 'Edit comments', %q{
  In order to be able to correct comment
  As a user
  I want to be able edit comments
} do

  given!(:user_author) { create(:user) }
  given!(:user) { create(:user) }
  given!(:post) { create(:post) }
  given!(:comment) { create(:comment, post: post, author: user_author) }
  given!(:post_with_old_comment) { create(:post) }
  given!(:old_comment) { create(:comment, post: post_with_old_comment) }

  scenario 'author edit new comment' do
    sign_in(user_author)
    visit post_path(post)

    click_on t('posts.comment.edit_comment')
    updated_text = "new text comment"
    fill_in 'Text', with: updated_text
    click_on t('comments.edit.update_comment')

    expect(page).to have_content updated_text
    expect(current_path).to eq post_path(post)
  end

  scenario 'author tries edit old comment' do
    sign_in(user_author)
    visit post_path(post_with_old_comment)

    expect(page).not_to have_link t('posts.comment.edit_comment')
  end

  scenario 'user tries edit post another user' do
    sign_in(user)
    visit post_path(post)

    expect(page).not_to have_link t('posts.comment.edit_comment')
  end

  scenario 'Non-authenticated user tries edit post' do
    visit post_path(post)

    expect(page).not_to have_link t('posts.comment.edit_comment')
  end
end
