require "rails_helper"

RSpec.describe "As a user", type: :feature do
  it "i can see a pets image, name, description, approximate age, sex, and adoption status on a show page" do
    shelter_1 = Shelter.create(name:    "Foothills Animal Shelter",
                               address: "580 McIntyre St",
                               city:    "Golden",
                               state:   "CO",
                               zip:     "80401")
    pet_1 = shelter_1.pets.create(image_url:       "https://images.unsplash.com/photo-1538083156950-7ad24f318e7c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                  name:            "Charlie",
                                  description:     "Yello Lab",
                                  approximate_age: "6",
                                  sex:             "Male",
                                  adoptable:       true)
    pet_2 = shelter_1.pets.create(image_url:       "https://images.unsplash.com/photo-1553854201-29e55f0625f7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                                  name:            "Moma",
                                  description:     "Pug",
                                  approximate_age: "2",
                                  sex:             "Female",
                                  adoptable:       false)

    visit "/pets/#{pet_1.id}"

    expect(page).to have_css("#petimg-#{pet_1.id}")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.description)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content("#{pet_1.name} is #{pet_1.adoption_status}")

    visit "/pets/#{pet_2.id}"

    expect(page).to have_css("#petimg-#{pet_2.id}")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.description)
    expect(page).to have_content(pet_2.approximate_age)
    expect(page).to have_content(pet_2.sex)
    expect(page).to have_content("#{pet_2.name} is #{pet_2.adoption_status}")
  end
end
