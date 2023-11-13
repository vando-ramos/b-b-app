require 'rails_helper'

describe 'User register rooms at their own guesthouse' do
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

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Hilton', corporate_name: 'Hilton Corporate',
                                    register_number: '123456789', phone_number: '98765-4321',
                                    email: 'hilton@hilton.com', full_address: full_address,
                                    description: 'Em frente a orla', payment_methods: payment_methods,
                                    pet_friendly: 'Sim', terms: 'Proibido fumar', check_in_time: '8:00',
                                    check_out_time: '9:00', status: 'ativa', user: host)

    Amenity.create!(name: 'TV')

    login_as(host)
    visit root_path
    click_on 'Pousada Hilton'
    click_on 'Register Room'
    fill_in 'Name', with: 'Paris Hilton'
    fill_in 'Maximum Guests', with: '3'
    fill_in 'Description', with: '1 cama de casal e 1 de solteiro'
    fill_in 'Dimension', with: '10 m2'
    fill_in 'Normal Price', with: '100'
    select 'Disponível', from: 'Status'
    check 'TV'
    fill_in 'Custom Price', with: '150'
    fill_in 'Start Date', with: '2023-12-20'
    fill_in 'End Date', with: '2024-02-20'
    click_on 'Send'

    expect(page).to have_content('Room registered successfully')
    expect(page).to have_content('Paris Hilton')
    expect(page).to have_content('3')
    expect(page).to have_content('1 cama de casal e 1 de solteiro')
    expect(page).to have_content('10 m2')
    expect(page).to have_content('100')
    expect(page).to have_content('disponivel')
    expect(page).to have_content('TV')
    expect(page).to have_content('De 2023-12-20 até 2024-02-20')
    expect(page).to have_content('150')
  end

  it 'with incomplete data' do
    host = User.create!(email: 'host@email.com', password: '123456')

    full_address = FullAddress.create!(address: 'Av Atlântica', number: 500, neighborhood: 'Copacabana',
                                        city: 'Rio de Janeiro', state: 'RJ', zip_code: '12012-001')

    pm1 = PaymentMethod.create!(name: 'Dinheiro')
    pm2 = PaymentMethod.create!(name: 'Débito')
    payment_methods = [pm1, pm2]

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Hilton', corporate_name: 'Hilton Corporate',
                                    register_number: '123456789', phone_number: '98765-4321',
                                    email: 'hilton@hilton.com', full_address: full_address,
                                    description: 'Em frente a orla', payment_methods: payment_methods,
                                    pet_friendly: 'Sim', terms: 'Proibido fumar', check_in_time: '8:00',
                                    check_out_time: '9:00', status: 'ativa', user: host)

    Amenity.create!(name: 'TV')

    login_as(host)
    visit root_path
    click_on 'Pousada Hilton'
    click_on 'Register Room'
    fill_in 'Name', with: ''
    fill_in 'Maximum Guests', with: ''
    fill_in 'Description', with: ''
    fill_in 'Normal Price', with: ''
    click_on 'Send'

    expect(page).to have_content('Unable to register room')
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Maximum guests can't be blank")
    expect(page).to have_content("Daily price can't be blank")
  end
end
