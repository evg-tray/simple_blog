require_relative '../acceptance_helper'

feature 'View tags', %q{
  In order to be able to view tags
  As an any user
  I want to be able view tags
} do

  given!(:posts) { create_list(:post, 3) }
  given!(:private_post) { create(:post, public: false) }

  before do
    posts[0].tag_list = 'tag1, tag2'
    posts[0].save
    posts[1].tag_list = 'tag2, tag3'
    posts[1].save
    posts[2].tag_list = 'tag3, tag4'
    posts[2].save
    private_post.tag_list = 'tag2'
    private_post.save
  end

  scenario 'Any user view tags' do
    visit posts_path

    expect(page).to have_link 'tag1'
    expect(page).to have_link 'tag2'
    expect(page).to have_link 'tag3'
    expect(page).to have_link 'tag4'
  end

  scenario 'Any user view public posts by tag' do
    visit posts_path

    click_on 'tag2'

    expect(page).to have_content posts[0].title
    expect(page).to have_content posts[1].title
    expect(page).not_to have_content posts[2].title
    expect(page).not_to have_content private_post.title
  end
end
