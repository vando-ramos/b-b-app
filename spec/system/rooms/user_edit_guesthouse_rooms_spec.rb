require 'rails_helper'

describe 'User edit guesthouse rooms' do
  it 'if authenticated' do
    visit root_path
    within('header nav') do
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

    am1 = Amenity.create!(name: 'Varanda')
    am2 = Amenity.create!(name: 'TV')
    amenities = [am1, am2]

    Room.create!(name: 'Paris Hilton', maximum_guests: 3, description: '1 cama de casal e 1 de solteiro',
                dimension: '10 m2', daily_price: '100', status: 'Disponível',
                amenities: amenities, guesthouse: guesthouse)

    login_as(host)
    visit root_path
    click_on 'My Guesthouse'
    click_on 'Edit Room'
    fill_in 'Name', with: 'Paris Hilton'
    fill_in 'Maximum Guests', with: '3'
    fill_in 'Description', with: '1 cama de casal e 1 de solteiro'
    fill_in 'Dimension', with: '10 m2'
    fill_in 'Normal Price', with: '100'
    select 'Disponível', from: 'Status'
    check 'TV'
    click_on 'Send'

    expect(page).to have_content('Room updated successfully')
    expect(page).to have_content('Paris Hilton')
    expect(page).to have_content('10 m2')
    expect(page).to have_content('100')
    expect(page).to have_content('TV')
  end

  it 'and keeps the required fields' do
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

    Room.create!(name: 'Paris Hilton', maximum_guests: 3, description: '1 cama de casal e 1 de solteiro',
                dimension: '10 m2', daily_price: '100', status: 'Disponível',
                amenities: amenities, guesthouse: guesthouse)

    login_as(host)
    visit root_path
    click_on 'My Guesthouse'
    click_on 'Edit Room'
    fill_in 'Name', with: ''
    fill_in 'Maximum Guests', with: ''
    fill_in 'Description', with: ''
    fill_in 'Dimension', with: ''
    fill_in 'Normal Price', with: ''
    select 'Disponível', from: ''
    click_on 'Send'

    expect(page).to have_content('Unable to update the room')
  end

  it 'if is responsible for it' do
    host = User.create!(email: 'host@email.com', password: '123456')
    admin = User.create!(email: 'admin@email.com', password: '123456')

    full_address1 = FullAddress.create!(address: 'Av Atlântica', number: 500, neighborhood: 'Copacabana',
                                        city: 'Rio de Janeiro', state: 'RJ', zip_code: '12012-001')

    pm1 = PaymentMethod.create!(name: 'Dinheiro')
    pm2 = PaymentMethod.create!(name: 'Débito')
    payment_methods = [pm1, pm2]

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Hilton', corporate_name: 'Hilton Corporate',
                                    register_number: '123456789', phone_number: '98765-4321',
                                    email: 'hilton@hilton.com', full_address: full_address1,
                                    description: 'Em frente a orla', payment_methods: payment_methods,
                                    pet_friendly: 'Sim', terms: 'Proibido fumar', check_in_time: '8:00',
                                    check_out_time: '9:00', status: 'ativa', user: host)

    am1 = Amenity.create!(name: 'Varanda')
    am2 = Amenity.create!(name: 'TV')
    amenities = [am1, am2]

    room = Room.create!(name: 'Paris Hilton', maximum_guests: 3, description: '1 cama de casal e 1 de solteiro',
                        dimension: '10 m2', daily_price: '100', status: 'Disponível',
                        amenities: amenities, guesthouse: guesthouse)

    login_as(admin)
    visit edit_room_path(room.id)

    expect(current_path).to eq(guesthouse_path(guesthouse.id))
    expect(page).not_to have_link('Edit Room')
    expect(page).to have_content("You don't have permission to edit this room")
  end
end
