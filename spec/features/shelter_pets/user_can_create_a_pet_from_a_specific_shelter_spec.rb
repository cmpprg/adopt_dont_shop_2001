require "rails_helper"

RSpec.describe "As a user", type: :feature do
  it "I can create a new pet that belongs to a particular shelter" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")

    visit "shelters/#{shelter_1.id}/pets"

    click_link("Create Pet")

    expect(current_path).to eql("/shelters/#{shelter_1.id}/pets/new")

    fill_in :image_url, with: "https://images.unsplash.com/flagged/photo-1563922597736-b037dd61aac0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"
    fill_in :name, with: "Jamil"
    fill_in :description, with: "Beautiful White Wolf"
    fill_in :approximate_age, with: "3"
    fill_in :sex, with: "female"

    click_button('Create Pet')
    new_pet = shelter_1.pets.last

    expect(current_path).to eql("/shelters/#{shelter_1.id}/pets")

    expect(page).to have_css("#petimg-#{new_pet.id}")
    expect(page).to have_content(new_pet.name)
    expect(page).to have_content(new_pet.approximate_age)
    expect(page).to have_content(new_pet.sex)
    expect(new_pet.adoption_status).to eql("adoptable")
  end
end
