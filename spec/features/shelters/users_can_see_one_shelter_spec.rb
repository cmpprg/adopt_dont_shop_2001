require 'rails_helper'

RSpec.describe 'shelter by id show page', type: :feature do
  it 'can show shelters name, address, city, state, and zip' do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit("/shelters/#{shelter_1.id}")
    address_id = find(:css, '#address')
    zone_id = find(:css, '#zone_info')

    expect(page).to have_content(shelter_1.name)
    expect(address_id).to have_content("Address: #{shelter_1.address}")
    expect(zone_id).to have_content("#{shelter_1.city}, #{shelter_1.state} #{shelter_1.zip}")
  end
end
