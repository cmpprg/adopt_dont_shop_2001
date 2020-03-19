require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do
  it "can see all shelters names" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: " 580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    shelter_2 = Shelter.create(name:    "Carson Animal Shelter",
                               address: "216 W Victoria St",
                               city:    "Gardena",
                               state:   "CA",
                               zip:     "90248")

    visit '/shelters'

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
  end

  it 'can click a link that takes you to new shelter form' do
    visit '/shelters'

    within('#new_shelter_link') do
      expect(page).to have_content('New Shelter')
    end
    expect(page).to have_link('New Shelter')

    click_link('New Shelter')

    expect(current_path).to eql('/shelters/new')
  end

end
