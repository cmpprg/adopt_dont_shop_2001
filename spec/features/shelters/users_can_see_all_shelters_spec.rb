require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do
  it "can see all shelters names" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: " 580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    shelter_2 = Shelter.create(name:    "Denver Animal Shelter",
                               address: "1241 W Bayaud Ave",
                               city:    "Denver",
                               state:   "CO",
                               zip:     "80223")

    visit '/shelters'

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
  end
end
