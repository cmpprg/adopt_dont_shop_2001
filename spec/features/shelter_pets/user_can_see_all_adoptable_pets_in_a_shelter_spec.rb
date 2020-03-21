require "rails_helper"

RSpec.describe "as a user", type: :feature do
  it 'i can see all adoptable pets from with a particular shelter' do
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
    pet_1 = shelter_1.pets.create(image_url:        "https://images.unsplash.com/photo-1518900673653-cf9fdd01e430?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80",
                                   name:            "Tom",
                                   description:     "Squirrel",
                                   approximate_age: "4",
                                   sex:             "Male",
                                   adoptable:       true,)
    pet_2 = shelter_1.pets.create(image_url:        "https://images.unsplash.com/photo-1548247416-ec66f4900b2e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=963&q=80",
                                   name:            "Jenkyl",
                                   description:     "Black Cat",
                                   approximate_age: "2",
                                   sex:             "Male",
                                   adoptable:       true,)
    pet_3 = shelter_1.pets.create(image_url:        "https://images.unsplash.com/photo-1580200131976-112bea9d35f5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80",
                                   name:            "Amara",
                                   description:     "Elephant",
                                   approximate_age: "33",
                                   sex:             "Female",
                                   adoptable:       false,)
    pet_4 = shelter_2.pets.create(image_url:        "https://images.unsplash.com/photo-1580598152173-e5fab42e08a5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=666&q=80",
                                   name:            "Oscar",
                                   description:     "Great Horned Owl",
                                   approximate_age: "12",
                                   sex:             "Female",
                                   adoptable:       true,)

    visit "/shelters/#{shelter_1.id}/pets"

    expect(page).to have_css("#img-#{pet_1.id}")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_css("#img-#{pet_2.id}")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.approximate_age)
    expect(page).to have_content(pet_2.sex)
    expect(page).to have_no_css("#img-#{pet_3.id}")
    expect(page).to have_no_content(pet_3.name)
    expect(page).to have_no_content(pet_3.approximate_age)
    expect(page).to have_no_content(pet_3.sex)
    expect(page).to have_no_css("#img-#{pet_4.id}")
    expect(page).to have_no_content(pet_4.name)
    expect(page).to have_no_content(pet_4.approximate_age)
    expect(page).to have_no_content(pet_4.sex)
  end
end
