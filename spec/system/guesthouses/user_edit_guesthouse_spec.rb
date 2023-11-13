require 'rails_helper'

describe 'User edits a guesthouse' do
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
                        terms: 'Proibido fumar', check_in_time: '8:00', check_out_time: '9:00', status: 'ativa',
                        user: host)

    login_as(host)
    visit root_path
    click_on 'Pousada Hilton'
    click_on 'Edit Guesthouse'
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
    check 'Dinheiro'
    select "Sim", from: "Pet Friendly"
    fill_in 'Terms', with: 'Proibido fumar'
    fill_in 'Check in time', with: '8:00'
    fill_in 'Check out time', with: '9:00'
    select 'ativa', from: 'Status'
    click_on 'Send'

    expect(page).to have_content('Guesthouse updated successfully')
    expect(page).to have_content('Pousada Hilton')
    expect(page).to have_content('Hilton Corporate')
    expect(page).to have_content('123456789')
    expect(page).to have_content('Av Atlântica')
    expect(page).to have_content('500')
    expect(page).to have_content('Copacabana')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('RJ')
    expect(page).to have_content('Dinheiro')
  end

  it 'and keeps the required fields' do
    host = User.create!(email: 'host@email.com', password: '123456')

    full_address = FullAddress.create!(address: 'Av Atlântica', number: 500, neighborhood: 'Copacabana',
                                        city: 'Rio de Janeiro', state: 'RJ', zip_code: '12012-001')

    pm1 = PaymentMethod.create!(name: 'Dinheiro')
    pm2 = PaymentMethod.create!(name: 'Débito')
    payment_methods = [pm1, pm2]

    Guesthouse.create!(brand_name: 'Pousada Hilton', corporate_name: 'Hilton Corporate', register_number: '123456789',
                        phone_number: '98765-4321', email: 'hilton@hilton.com', full_address: full_address,
                        description: 'Em frente a orla', payment_methods: payment_methods, pet_friendly: 'Sim',
                        terms: 'Proibido fumar', check_in_time: '8:00', check_out_time: '9:00', status: 'ativa',
                        user: host)

    login_as(host)
    visit root_path
    click_on 'Pousada Hilton'
    click_on 'Edit Guesthouse'
    fill_in 'Brand Name', with: ''
    fill_in 'Phone Number', with: ''
    fill_in 'Email', with: ''
    fill_in 'Zip Code', with: ''
    fill_in 'Description', with: ''
    fill_in 'Terms', with: ''
    fill_in 'Check in time', with: ''
    fill_in 'Check out time', with: ''
    click_on 'Send'

    expect(page).to have_content('Unable to update the guesthouse')
  end

  it 'if is responsible for it' do
    host = User.create!(email: 'host@email.com', password: '123456')
    admin = User.create!(email: 'admin@email.com', password: '123456')

    full_address = FullAddress.create!(address: 'Av Atlântica', number: 500, neighborhood: 'Copacabana',
                                        city: 'Rio de Janeiro', state: 'RJ', zip_code: '12012-001')

    pm1 = PaymentMethod.create!(name: 'Dinheiro')
    pm2 = PaymentMethod.create!(name: 'Débito')
    payment_methods = [pm1, pm2]

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Hilton', corporate_name: 'Hilton Corporate', register_number: '123456789',
                                    phone_number: '98765-4321', email: 'hilton@hilton.com', full_address: full_address,
                                    description: 'Em frente a orla', payment_methods: payment_methods, pet_friendly: 'Sim',
                                    terms: 'Proibido fumar', check_in_time: '8:00', check_out_time: '9:00', status: 'ativa',
                                    user: admin)

    login_as(admin)
    visit edit_room_path(guesthouse.id)

    expect(current_path).to eq(guesthouse_path(guesthouse.id))
    expect(page).not_to have_link('Edit Guesthouse')
  end
end
