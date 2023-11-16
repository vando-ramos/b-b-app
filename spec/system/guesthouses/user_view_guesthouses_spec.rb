require 'rails_helper'

describe 'User visits homepage' do
  it "and see the applicaton's name" do
  visit root_path

  expect(page).to have_content('B&B')
  expect(page).to have_link('B&B', href: root_path)
  end

  it 'and sees the registered guesthouses' do
    host = User.create!(email: 'host@email.com', password: '123456')
    admin = User.create!(email: 'admin@email.com', password: '123456')

    full_address1 = FullAddress.create!(address: 'Av Atlântica', number: 500, neighborhood: 'Copacabana',
                                        city: 'Rio de Janeiro', state: 'RJ', zip_code: '12012-001')
    full_address2 = FullAddress.create!(address: 'Rua Brisa do Mar', number: 500, neighborhood: 'Praia Seca',
                                        city: 'Araruama', state: 'RJ', zip_code: '12012-001')

    pm1 = PaymentMethod.create!(name: 'Dinheiro')
    pm2 = PaymentMethod.create!(name: 'Débito')
    payment_methods = [pm1, pm2]

    Guesthouse.create!(brand_name: 'Pousada Hilton', corporate_name: 'Hilton Corporate', register_number: '123456789',
                        phone_number: '98765-4321', email: 'hilton@hilton.com', full_address: full_address1,
                        description: 'Em frente a orla', payment_methods: payment_methods, pet_friendly: 'Sim',
                        terms: 'Proibido fumar', check_in_time: '8:00', check_out_time: '9:00', status: 'ativa',
                        user: host)
    Guesthouse.create!(brand_name: 'Brisa do Mar', corporate_name: 'Brisa do Mar Ltda', register_number: '123123123',
                        phone_number: '98765-4321', email: 'brisa@email.com', full_address: full_address2,
                        description: 'Em frente a orla', payment_methods: payment_methods, pet_friendly: 'Sim',
                        terms: 'Proibido fumar', check_in_time: '10:00', check_out_time: '8:00', status: 'ativa',
                        user: admin)

    visit root_path

    expect(page).not_to have_content('There is no registered guesthouse')
    expect(page).to have_content('Pousada Hilton')
    expect(page).to have_content('Rio de Janeiro - RJ')
    expect(page).to have_content('Brisa do Mar')
    expect(page).to have_content('Araruama - RJ')
  end

  it 'and sees a menu of cities' do
    host = User.create!(email: 'host@email.com', password: '123456')
    admin = User.create!(email: 'admin@email.com', password: '123456')

    full_address1 = FullAddress.create!(address: 'Av Atlântica', number: 500, neighborhood: 'Copacabana',
                                        city: 'Rio de Janeiro', state: 'RJ', zip_code: '12012-001')
    full_address2 = FullAddress.create!(address: 'Rua Brisa do Mar', number: 500, neighborhood: 'Praia Seca',
                                        city: 'Araruama', state: 'RJ', zip_code: '12012-001')

    pm1 = PaymentMethod.create!(name: 'Dinheiro')
    pm2 = PaymentMethod.create!(name: 'Débito')
    payment_methods = [pm1, pm2]

    Guesthouse.create!(brand_name: 'Pousada Hilton', corporate_name: 'Hilton Corporate', register_number: '123456789',
                        phone_number: '98765-4321', email: 'hilton@hilton.com', full_address: full_address1,
                        description: 'Em frente a orla', payment_methods: payment_methods, pet_friendly: 'Sim',
                        terms: 'Proibido fumar', check_in_time: '8:00', check_out_time: '9:00', status: 'ativa',
                        user: host)
    Guesthouse.create!(brand_name: 'Brisa do Mar', corporate_name: 'Brisa do Mar Ltda', register_number: '123123123',
                        phone_number: '98765-4321', email: 'brisa@email.com', full_address: full_address2,
                        description: 'Em frente a orla', payment_methods: payment_methods, pet_friendly: 'Sim',
                        terms: 'Proibido fumar', check_in_time: '10:00', check_out_time: '8:00', status: 'ativa',
                        user: admin)

    visit root_path

    expect(page).to have_link('Rio de Janeiro')
    expect(page).to have_link('Araruama')
  end

  it 'and sees the guesthouses by city' do
    host = User.create!(email: 'host@email.com', password: '123456')
    admin = User.create!(email: 'admin@email.com', password: '123456')

    full_address1 = FullAddress.create!(address: 'Av Atlântica', number: 500, neighborhood: 'Copacabana',
                                        city: 'Rio de Janeiro', state: 'RJ', zip_code: '12012-001')
    full_address2 = FullAddress.create!(address: 'Rua Brisa do Mar', number: 500, neighborhood: 'Praia Seca',
                                        city: 'Araruama', state: 'RJ', zip_code: '12012-001')

    pm1 = PaymentMethod.create!(name: 'Dinheiro')
    pm2 = PaymentMethod.create!(name: 'Débito')
    payment_methods = [pm1, pm2]

    Guesthouse.create!(brand_name: 'Pousada Hilton', corporate_name: 'Hilton Corporate', register_number: '123456789',
                        phone_number: '98765-4321', email: 'hilton@hilton.com', full_address: full_address1,
                        description: 'Em frente a orla', payment_methods: payment_methods, pet_friendly: 'Sim',
                        terms: 'Proibido fumar', check_in_time: '8:00', check_out_time: '9:00', status: 'ativa',
                        user: host)
    Guesthouse.create!(brand_name: 'Brisa do Mar', corporate_name: 'Brisa do Mar Ltda', register_number: '123123123',
                        phone_number: '98765-4321', email: 'brisa@email.com', full_address: full_address2,
                        description: 'Em frente a orla', payment_methods: payment_methods, pet_friendly: 'Sim',
                        terms: 'Proibido fumar', check_in_time: '10:00', check_out_time: '8:00', status: 'ativa',
                        user: admin)

    visit root_path
    click_on 'Rio de Janeiro'

    expect(current_path).to eq(guesthouses_by_city_path('Rio de Janeiro'))
    expect(page).to have_content('Pousada Hilton')
    expect(page).not_to have_content('Brisa do Mar')
  end
end
