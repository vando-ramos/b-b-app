require 'rails_helper'

describe 'User confirm reservation' do
  it 'if authenticated as guest' do
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

    visit root_path
    click_on 'Pousada Hilton'
    click_on 'Book'
    within('.reservation-form') do
      fill_in 'Start Date', with: '2023-12-23'
      fill_in 'End Date', with: '2024-01-02'
      fill_in 'Number of Guests', with: '3'
      click_on 'Send'
    end
    click_on 'Confirm Booking'

    expect(current_path).to eq(new_guest_session_path)
  end
end
