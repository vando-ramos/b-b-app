require 'rails_helper'

describe 'A host user register your guesthouse' do
  it 'if authenticated' do
    visit root_path
    within('header nav') do
      click_on 'Sign in'
    end

    expect(current_path).to eq(new_user_session_path)
  end

  it 'successfully' do
    host = User.create!(email: 'host@email.com', password: '123456')
    payment_method = PaymentMethod.create!(name: 'Dinheiro')

    login_as(host)
    visit root_path
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
    check 'Dinheiro'
    select "Sim", from: "Pet Friendly"
    fill_in 'Terms', with: 'Proibido fumar'
    fill_in 'Check in time', with: '8:00'
    fill_in 'Check out time', with: '9:00'
    select 'ativa', from: 'Status'
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
    expect(page).to have_content('ativa')
  end

  it 'with incomplete data' do
    host = User.create!(email: 'host@email.com', password: '123456')

    login_as(host)
    visit root_path
    click_on 'Register Your Guesthouse'
    fill_in 'Brand Name', with: ''
    fill_in 'Phone Number', with: ''
    fill_in 'Email', with: ''
    fill_in 'Zip Code', with: ''
    fill_in 'Description', with: ''
    fill_in 'Terms', with: ''
    fill_in 'Check in time', with: ''
    fill_in 'Check out time', with: ''
    click_on 'Send'

    expect(page).to have_content("Brand name can't be blank")
    expect(page).to have_content("Phone number can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Full address zip code can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Terms can't be blank")
    expect(page).to have_content("Check in time can't be blank")
    expect(page).to have_content("Check out time can't be blank")
  end

  it 'and must only have one registered guesthouse' do
    host = User.create!(email: 'host@email.com', password: '123456')

    full_address = FullAddress.create!(address: 'Av Atlântica', number: 500, neighborhood: 'Copacabana',
                                        city: 'Rio de Janeiro', state: 'RJ', zip_code: '12012-001')

    pm1 = PaymentMethod.create!(name: 'Dinheiro')
    pm2 = PaymentMethod.create!(name: 'Débito')
    payment_methods = [pm1, pm2]

    guesthouse = Guesthouse.create!(brand_name: 'Pousada Hilton', corporate_name: 'Hilton Corporate', register_number: '123456789',
                                    phone_number: '98765-4321', email: 'hilton@hilton.com', full_address: full_address,
                                    description: 'Em frente a orla', payment_methods: payment_methods, pet_friendly: 'Sim',
                                    terms: 'Proibido fumar', check_in_time: '8:00', check_out_time: '9:00', status: 'ativa',
                                    user: host)

    login_as(host)
    visit root_path
    click_on 'Register Your Guesthouse'

    expect(current_path).not_to eq(new_guesthouse_path)
    expect(current_path).to eq(guesthouse_path(guesthouse.id))
    expect(page).to have_content("You already have a registered guesthouse")
  end
end
