require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  it "I can see all shelters names" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    shelter_2 = Shelter.create(name:    "Carson Animal Shelter",
                               address: "216 W Victoria St",
                               city:    "Gardena",
                               state:   "CA",
                               zip:     "90248")

    visit '/shelters'

    within("#list_item_#{shelter_1.id}") do
      expect(page).to have_content(shelter_1.name)
    end
    within("#list_item_#{shelter_2.id}") do
      expect(page).to have_content(shelter_2.name)
    end

  end

  it 'I can click a link that takes you to new shelter form' do
    visit '/shelters'

    click_link('New Shelter')

    expect(current_path).to eql('/shelters/new')
  end

  it "I can see and click an update link for each shelter listing." do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    shelter_2 = Shelter.create(name:    "Carson Animal Shelter",
                               address: "216 W Victoria St",
                               city:    "Gardena",
                               state:   "CA",
                               zip:     "90248")

    visit "/shelters"

    within("#list_item_#{shelter_1.id}") do
      click_link('Update Shelter')

      expect(current_path).to eql("/shelters/#{shelter_1.id}/edit")
    end

    visit '/shelters'

    within("#list_item_#{shelter_2.id}") do
      click_link('Update Shelter')

      expect(current_path).to eql("/shelters/#{shelter_2.id}/edit")
    end
  end

  it "I can see and click a delete link for each shelter listing " do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    shelter_2 = Shelter.create(name:    "Carson Animal Shelter",
                               address: "216 W Victoria St",
                               city:    "Gardena",
                               state:   "CA",
                               zip:     "90248")

    visit "/shelters"

    within(".list") do
      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end
    within("#list_item_#{shelter_1.id}") do
      expect(page).to have_link('Delete Shelter')
    end
    within("#list_item_#{shelter_2.id}") do
      expect(page).to have_link('Delete Shelter')
    end
    within("#list_item_#{shelter_1.id}") do
      click_on("Delete Shelter")
    end

    expect(page).to have_no_content(shelter_1.name)
    expect(Shelter.exists?(shelter_1.id)).to eql(false)
    expect(page).to have_content(shelter_2.name)
  end
end
