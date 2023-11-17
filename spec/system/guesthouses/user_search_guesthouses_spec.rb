require 'rails_helper'

describe 'User search for guesthouses' do
  it 'from any application screen' do
    visit root_path

    within('header nav') do
      expect(page).to have_field('Search Guesthouse')
      expect(page).to have_button('Search')
    end
  end

  it 'and search a guesthouse' do
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

    visit root_path
    fill_in 'Search Guesthouse', with: 'Pousada Hilton'
    click_on 'Search'

    expect(current_path).to eq(search_guesthouses_path)
    expect(page).to have_content("Search results for: Pousada Hilton")
    expect(page).to have_content('1 found')
    expect(page).to have_content('Pousada Hilton')
  end
end
