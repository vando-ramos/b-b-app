require 'rails_helper'

describe 'User authenticates' do
  it 'successfully' do
    visit root_path
    click_on 'Sign in'
    click_on 'Sign up'
    fill_in 'Email', with: 'host@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content('host@email.com')
    expect(page).to have_button('Sign out')
    expect(page).to have_content('Welcome! You have signed up successfully')
  end
end
