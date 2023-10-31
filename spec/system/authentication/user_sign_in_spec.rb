require 'rails_helper'

describe 'User authenticates' do
  it 'sucessfully' do
    User.create!(email: 'host@email.com', password: '123456')

    visit root_path
    click_on 'Sign in'
    within('form') do
      fill_in 'Email', with: 'host@email.com'
      fill_in 'Password', with: '123456'
      click_on 'Sign in'
    end

    expect(page).to have_content('Signed in successfully')
    within('nav') do
      expect(page).not_to have_link('Sign in')
      expect(page).to have_button('Sign out')
      expect(page).to have_content('host@email.com')
    end
  end

  it 'and signs out' do
    User.create!(email: 'host@email.com', password: '123456')

    visit root_path
    click_on 'Sign in'
    within('form') do
      fill_in 'Email', with: 'host@email.com'
      fill_in 'Password', with: '123456'
      click_on 'Sign in'
    end
    click_on 'Sign out'

    expect(page).to have_content('Signed out successfully')
    expect(page).to have_link('Sign in')
    expect(page).not_to have_button('Sign out')
    within('nav') do
      expect(page).not_to have_content('host@email.com')
    end
  end
end
