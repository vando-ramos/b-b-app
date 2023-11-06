require 'rails_helper'

describe 'Host user register your guesthouse' do
  it 'if authenticated' do
    visit root_path
    within('nav') do
      click_on 'Sign in'
    end

    expect(current_path).to eq(new_user_session_path)
  end

  it 'successfully' do
    host = User.create!(email: 'host@email.com', password: '123456')

    full_address = FullAddress.create!(address: 'Av Atlântica, 500', neighborhood: 'Copacabana',
                                        city: 'Rio de Janeiro', state: 'RJ', zip_code: '12012-001')

    payment_method = PaymentMethod.create!(name: 'Dinheiro')

    login_as(host)
    visit root_path
    click_on 'My Guesthouse'
    click_on 'Register Your Guesthouse'
    fill_in 'Brand Name', with: 'Pousada Hilton'
    fill_in 'Corporate Name', with: 'Hilton Corporate'
    fill_in 'Register Number', with: '123456789'
    fill_in 'Phone Number', with: '98765-4321'
    fill_in 'Email', with: 'hilton@hilton.com'
    fill_in 'Address', with: 'Av Atlântica'
    fill_in 'Number', with: '500'
    fill_in 'Neighborhood', with: 'Copacabana'
    fill_in 'City', with: 'Rio de Janeiro'
    fill_in 'State', with: 'RJ'
    fill_in 'Zip Code', with: '12012-001'
    fill_in 'Description', with: 'Em frente a orla'
    check 'Dinheiro' # In Payment Methods
    # fill_in 'Pet Friendly', with: 'Sim'
    fill_in 'Terms', with: 'Proibido fumar'
    fill_in 'Check in time', with: '8:00'
    fill_in 'Check out time', with: '9:00'
    # fill_in 'Status', with: 'Ativa'
    click_on 'Send'

    expect(page).to have_content('Guesthouse registered successfully')
    expect(page).to have_content('Pousada Hilton')
    expect(page).to have_content('Hilton Corporate')
    expect(page).to have_content('123456789')
    expect(page).to have_content('98765-4321')
    expect(page).to have_content('hilton@hilton.com')
    expect(page).to have_content('Av Atlântica, 500 - Copacabana - Rio de Janeiro - RJ - Zip Code: 12012-001')
    expect(page).to have_content('Em frente a orla')
    expect(page).to have_content('Dinheiro')
    expect(page).to have_content('Sim')
    expect(page).to have_content('Proibido fumar')
    expect(page).to have_content('8:00')
    expect(page).to have_content('9:00')
    expect(page).to have_content('Ativa')
  end
end
