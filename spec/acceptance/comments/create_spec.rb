require_relative '../acceptance_helper'

feature 'Create comments', %q{
  In order to be able to comment post
  As a user
  I want to be able create comments
} do

  given(:user) { create(:user) }
  given(:post) { create(:post) }
  given(:comment) { build(:comment) }

  scenario 'User create comment', js: true do
    sign_in(user)

    visit post_path(post)

    find('#comment_text').set(comment.text)
    click_on t('posts.comments.create_comment')

    expect(page).to have_content comment.text
  end

  scenario 'Not-authenticated user tries create comment' do
    visit post_path(post)

    expect(page).not_to have_link t('posts.comments.create_comment')
  end
end
