require_relative '../acceptance_helper'

feature 'Edit posts', %q{
  In order to be able to correct post
  As a user
  I want to be able edit posts
} do

  given(:user_author) { create(:user) }
  given(:user) { create(:user) }
  given(:post) { create(:post, author: user_author) }

  scenario 'author edit post title' do
    sign_in(user_author)
    visit post_path(post)

    click_on t('posts.show.edit_post')
    updated_title = "new post name"
    fill_in 'Title', with: updated_title
    click_on t('posts.form.update_post')

    expect(page).to have_content updated_title
  end

  scenario 'author edit post body' do
    sign_in(user_author)
    visit post_path(post)

    click_on t('posts.show.edit_post')
    updated_body = "new post body" * 5
    fill_in 'Body', with: updated_body
    click_on t('posts.form.update_post')

    expect(page).to have_content updated_body
  end

  scenario 'author edit post date' do
    sign_in(user_author)
    visit post_path(post)

    click_on t('posts.show.edit_post')
    updated_date = (post.created_at + 1.day).strftime('%d.%m.%Y %H:%M')
    find('#post_created_at').set(updated_date)
    click_on t('posts.form.update_post')

    visit posts_path
    expect(page).to have_content updated_date
  end

  scenario 'user tries edit post another user' do
    sign_in(user)
    visit post_path(post)

    expect(page).not_to have_link t('posts.show.edit_post')
  end

  scenario 'Non-authenticated user tries edit post' do
    visit post_path(post)

    expect(page).not_to have_link t('posts.show.edit_post')
  end
end
