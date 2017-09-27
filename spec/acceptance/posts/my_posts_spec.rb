require_relative '../acceptance_helper'

feature 'View my posts', %q{
  In order to be able to view my posts
  As user
  I want to be able view my posts
} do

  given(:user_author) { create(:user) }
  given(:user) { create(:user) }
  given!(:posts) { create_list(:post, 2, author: user_author) }
  given!(:another_user_posts) { create_list(:post, 2) }

  scenario 'Author view his posts' do
    sign_in(user_author)
    visit my_posts_path

    expect(page).to have_content posts[0].title
    expect(page).to have_content posts[1].title
    expect(page).not_to have_content another_user_posts[0].title
    expect(page).not_to have_content another_user_posts[1].title
  end

  scenario 'user without posts view his posts' do
    sign_in(user)
    visit my_posts_path
    expect(page).to have_content t('posts.no_posts')
  end

  scenario 'Non-authenticated user tries view his posts' do
    visit my_posts_path

    expect(page).to have_content t('devise.failure.unauthenticated')
    expect(current_path).to eq new_user_session_path
  end
end
