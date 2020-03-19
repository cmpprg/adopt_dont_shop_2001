require 'rails_helper'

RSpec.describe 'update shelter info page', type: :feature do
  it 'can see form fields for name, address, city, state, zip, and a button to submit' do
    shelter = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "shelters/#{shelter.id}/edit"

    within('.update_form') do
      expect(page).to have_field(:name)
      expect(page).to have_field(:address)
      expect(page).to have_field(:city)
      expect(page).to have_field(:state)
      expect(page).to have_field(:zip)
    end
  end

  it 'can use form to update shelter' do
    shelter = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "shelters/#{shelter.id}/edit"

    within('.update_form') do
      fill_in :name, with: "Updated Shelter Name"
      fill_in :address, with: "Updated Address"
      fill_in :city, with: "Updated City"
      fill_in :state ,with: "Updated State"
      fill_in :zip, with: "Updated Zip"
      click_button('Submit Updates')
    end
    expect(current_path).to eql("/shelters/#{shelter.id}")

    updated_shelter = Shelter.find("#{shelter.id}")

    within('#title') do
      expect(page).to have_content(updated_shelter.name)
    end
    within('#address p:first-child') do
      expect(page).to have_content("Address: #{updated_shelter.address}")
    end
    within('#address p:nth-child(2)') do
      expect(page).to have_content("#{updated_shelter.city}, #{updated_shelter.state} #{updated_shelter.zip}")
    end
  end
end
