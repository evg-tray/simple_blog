require_relative '../acceptance_helper'

feature 'Create posts', %q{
  In order to be able to share some information
  As a user
  I want to be able create posts
} do

  given(:user) { create(:user) }
  given(:post) { build(:post) }

  scenario 'User create post' do
    sign_in(user)

    visit new_post_path

    fill_in 'Title', with: post.title
    fill_in 'Body', with: post.body

    within '.panel' do
      click_on t('posts.form.create_post')
    end

    visit posts_path
    expect(page).to have_content post.title
    within '.table' do
      expect(page).to have_content user.username
    end
  end

  scenario 'Not-authenticated user tries create post' do
    visit new_post_path

    expect(page).to have_content t('devise.failure.unauthenticated')
    expect(current_path).to eq new_user_session_path
  end
end
