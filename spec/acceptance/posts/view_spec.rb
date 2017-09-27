require_relative '../acceptance_helper'

feature 'View posts', %q{
  In order to be able to view posts
  As an any user
  I want to be able view posts
} do

  given!(:posts) { create_list(:post, 2) }
  given(:user) { create(:user) }
  given!(:private_post) { create(:post, author: user, public: false) }

  scenario 'Any user view public posts' do
    visit posts_path

    expect(page).to have_content posts[0].title
    expect(page).to have_content posts[0].author.username
    expect(page).to have_content posts[1].title
    expect(page).to have_content posts[1].author.username
    expect(page).not_to have_content private_post.title
  end

  scenario 'Any user view public post' do
    visit post_path(posts[0])
    expect(page).to have_content posts[0].title
    expect(page).to have_content posts[0].body

    visit post_path(posts[1])
    expect(page).to have_content posts[1].title
    expect(page).to have_content posts[1].body
  end

  scenario 'Not-authenticated user tries view private post' do
    visit post_path(private_post)
    expect(page).to have_content 'Forbidden.'
  end

  scenario 'Author view his private post' do
    sign_in(user)
    visit post_path(private_post)
    expect(page).to have_content private_post.title
  end
end
