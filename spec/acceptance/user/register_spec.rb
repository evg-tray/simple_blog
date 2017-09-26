require_relative '../acceptance_helper'

feature 'Register user', %q{
  In order to be able to save recipes
  As non-authenticated user
  I want to register new user
} do

  given(:user) { create(:user) }

  scenario 'Register user' do
    visit new_user_session_path
    click_on t('devise.shared.links.sign_up')
    fill_in 'Username', with: Faker::Internet.unique.user_name
    fill_in 'Email', with: Faker::Internet.unique.email
    pass = Faker::Internet.password
    fill_in 'Password', with: pass
    fill_in 'Password confirmation', with: pass
    click_on t('devise.registrations.new.sign_up')

    expect(page).to have_content t('devise.registrations.signed_up')
  end

  scenario 'try register user with exists username' do
    visit new_user_session_path
    click_on t('devise.shared.links.sign_up')
    fill_in 'Username', with: user.username
    fill_in 'Email', with: Faker::Internet.unique.email
    pass = Faker::Internet.password
    fill_in 'Password', with: pass
    fill_in 'Password confirmation', with: pass
    click_on t('devise.registrations.new.sign_up')

    expect(page).to have_content 'Username has already been taken'
  end
end
