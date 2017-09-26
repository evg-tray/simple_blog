require_relative '../acceptance_helper'

feature 'View posts', %q{
  In order to be able to view posts
  As an any user
  I want to be able view posts
} do

  given!(:posts) { create_list(:post, 2) }

  scenario 'Any user view posts' do
    visit posts_path

    expect(page).to have_content posts[0].title
    expect(page).to have_content posts[0].author.username
    expect(page).to have_content posts[1].title
    expect(page).to have_content posts[1].author.username
  end

  scenario 'Any user view post' do
    visit post_path(posts[0])
    expect(page).to have_content posts[0].title
    expect(page).to have_content posts[0].body

    visit post_path(posts[1])
    expect(page).to have_content posts[1].title
    expect(page).to have_content posts[1].body
  end
end
