require_relative '../acceptance_helper'

feature 'View comments', %q{
  In order to be able to view comments
  As an any user
  I want to be able view comments
} do

  given!(:post) { create(:post) }
  given!(:comments) { create_list(:comment, 2, post: post) }

  scenario 'Any user view comments' do
    visit post_path(post)

    expect(page).to have_content comments[0].text
    expect(page).to have_content comments[1].text
  end
end
