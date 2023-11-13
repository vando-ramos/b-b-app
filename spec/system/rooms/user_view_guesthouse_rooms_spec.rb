require 'rails_helper'

describe 'A user sees the rooms of a guesthouse' do
  it 'successfully'  do
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

    am1 = Amenity.create!(name: 'Varanda')
    am2 = Amenity.create!(name: 'Ar Condicionado')
    am3 = Amenity.create!(name: 'TV')
    amenities = [am1, am2, am3]

    custom_price = CustomPrice.create!(daily_price: '150', start_date: '2023-12-20', end_date: '2024-02-20')

    Room.create!(name: 'Paris Hilton', maximum_guests: 3, description: '1 cama de casal e 1 de solteiro',
                dimension: '10 m2', daily_price: '100', status: 'Disponível',
                amenities: amenities, custom_price: custom_price, guesthouse: guesthouse)

    visit root_path
    click_on 'Pousada Hilton'

    expect(current_path).to eq(guesthouse_path(guesthouse.id))
    expect(page).to have_content('Rooms')
    expect(page).to have_content('Paris Hilton')
    expect(page).to have_content('3')
    expect(page).to have_content('1 cama de casal e 1 de solteiro')
    expect(page).to have_content('10 m2')
    expect(page).to have_content('$100')
    expect(page).to have_content('Varanda')
  end

  it 'and only the rooms within the selected guesthouse' do
    host = User.create!(email: 'host@email.com', password: '123456')
    admin = User.create!(email: 'admin@email.com', password: '123456')

    full_address = FullAddress.create!(address: 'Av Atlântica', number: 500, neighborhood: 'Copacabana',
                                        city: 'Rio de Janeiro', state: 'RJ', zip_code: '12012-001')

    pm1 = PaymentMethod.create!(name: 'Dinheiro')
    pm2 = PaymentMethod.create!(name: 'Débito')
    payment_methods = [pm1, pm2]

    guesthouse1 = Guesthouse.create!(brand_name: 'Pousada Hilton', corporate_name: 'Hilton Corporate',
                                    register_number: '123456789', phone_number: '98765-4321',
                                    email: 'hilton@hilton.com', full_address: full_address,
                                    description: 'Em frente a orla', payment_methods: payment_methods,
                                    pet_friendly: 'Sim', terms: 'Proibido fumar', check_in_time: '8:00',
                                    check_out_time: '9:00', status: 'ativa', user: host)

    guesthouse2 = Guesthouse.create!(brand_name: 'Brisa do Mar', corporate_name: 'Brisa do Mar Ltda',
                                    register_number: '123123123', phone_number: '98765-4321',
                                    email: 'brisa@email.com', full_address: full_address,
                                    description: 'Em frente a orla', payment_methods: payment_methods,
                                    pet_friendly: 'Sim', terms: 'Proibido fumar', check_in_time: '10:00',
                                    check_out_time: '8:00', status: 'inativa', user: admin)

    am1 = Amenity.create!(name: 'Varanda')
    am2 = Amenity.create!(name: 'Ar Condicionado')
    am3 = Amenity.create!(name: 'TV')
    amenities = [am1, am2, am3]

    custom_price = CustomPrice.create!(daily_price: '150', start_date: '2023-12-20', end_date: '2024-02-20')

    Room.create!(name: 'Paris Hilton', maximum_guests: 3, description: '1 cama de casal e 1 de solteiro',
                dimension: '10 m2', daily_price: '100', status: 'Disponível',
                amenities: amenities, custom_price: custom_price, guesthouse: guesthouse1)

    Room.create!(name: 'Quarto 101', maximum_guests: 1, description: '1 cama de solteiro',
                dimension: '3 m2', daily_price: '60', status: 'Disponível',
                amenities: amenities, custom_price: custom_price, guesthouse: guesthouse2)

    visit root_path
    click_on 'Pousada Hilton'

    expect(page).to have_content('Rooms')
    expect(page).to have_content('Paris Hilton')
    expect(page).not_to have_content('Quarto 101')
  end

  it 'and there are no registered rooms' do
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

    visit root_path
    click_on 'Pousada Hilton'

    expect(page).to have_content('Rooms')
    expect(page).to have_content('There are no registered rooms')
  end

  it 'and only available rooms' do
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

    am1 = Amenity.create!(name: 'Varanda')
    am2 = Amenity.create!(name: 'TV')
    amenities = [am1, am2]

    custom_price = CustomPrice.create!(daily_price: '150', start_date: '2023-12-20', end_date: '2024-02-20')

    Room.create!(name: 'Paris Hilton', maximum_guests: 3, description: '1 cama de casal e 1 de solteiro',
                dimension: '10 m2', daily_price: '100', status: 'Disponível',
                amenities: amenities, custom_price: custom_price, guesthouse: guesthouse)

    Room.create!(name: 'Madona', maximum_guests: 1, description: '1 cama de solteiro',
                dimension: '3 m2', daily_price: '80', status: 'Indisponível',
                amenities: amenities, custom_price: custom_price, guesthouse: guesthouse)

    visit root_path
    click_on 'Pousada Hilton'

    expect(page).to have_content('Rooms')
    expect(page).to have_content('Paris Hilton')
    expect(page).not_to have_content('Madona')
  end
end
