require_relative '../acceptance_helper'

feature 'Delete posts', %q{
  In order to be able to delete incorrect posts
  As a user
  I want to be able delete posts
} do

  given!(:user_author) { create(:user) }
  given!(:user) { create(:user) }
  given!(:post) { create(:post, author: user_author) }

  scenario 'author delete post' do
    sign_in(user_author)
    visit post_path(post)

    click_on t('posts.show.delete_post')

    expect(page).not_to have_content post.title
    expect(current_path).to eq posts_path
  end

  scenario 'user tries delete post another user' do
    sign_in(user)
    visit post_path(post)

    expect(page).not_to have_link t('posts.show.delete_post')
  end

  scenario 'Non-authenticated user tries delete post' do
    visit post_path(post)

    expect(page).not_to have_link t('posts.show.delete_post')
  end
end
