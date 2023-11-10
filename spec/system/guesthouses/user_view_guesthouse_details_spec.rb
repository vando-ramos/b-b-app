require 'rails_helper'

describe 'Host user sees guesthouse details' do
  it 'if authenticated' do
    visit root_path
    within('nav') do
      click_on 'Sign in'
    end

    expect(current_path).to eq(new_user_session_path)
  end

  it 'successfully' do
    host = User.create!(email: 'host@email.com', password: '123456')

    full_address = FullAddress.create!(address: 'Av Atlântica', number: 500, neighborhood: 'Copacabana',
                                        city: 'Rio de Janeiro', state: 'RJ', zip_code: '12012-001')

    pm1 = PaymentMethod.create!(name: 'Dinheiro')
    pm2 = PaymentMethod.create!(name: 'Débito')
    payment_methods = [pm1, pm2]

    Guesthouse.create!(brand_name: 'Pousada Hilton', corporate_name: 'Hilton Corporate', register_number: '123456789',
                        phone_number: '98765-4321', email: 'hilton@hilton.com', full_address: full_address,
                        description: 'Em frente a orla', payment_methods: payment_methods, pet_friendly: 'Sim',
                        terms: 'Proibido fumar', check_in_time: '8:00', check_out_time: '9:00', status: 'Ativa',
                        user: host)

    login_as(host)
    visit root_path
    click_on 'Pousada Hilton'

    expect(page).to have_content('Pousada Hilton')
    expect(page).to have_content('Hilton Corporate')
    expect(page).to have_content('123456789')
    expect(page).to have_content('98765-4321')
    expect(page).to have_content('hilton@hilton.com')
    expect(page).to have_content('Av Atlântica, 500 - Copacabana - Rio de Janeiro - RJ - Zip Code: 12012-001')
    expect(page).to have_content('Em frente a orla')
    expect(page).to have_content('Dinheiro Débito')
    expect(page).to have_content('Sim')
    expect(page).to have_content('Proibido fumar')
    expect(page).to have_content('8:00')
    expect(page).to have_content('9:00')
    expect(page).to have_content('Ativa')
  end

  it 'and there is no registered guesthouse' do
    host = User.create!(email: 'host@email.com', password: '123456')

    login_as(host)
    visit root_path

    expect(page).to have_content('There is no registered guesthouse')
  end
end
