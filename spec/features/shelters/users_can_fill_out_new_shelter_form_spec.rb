require 'rails_helper'

RSpec.describe 'new shelter form page', type: :feature do
  it 'can see form for new shelter' do
    visit '/shelters/new'

    within('.new_shelter_form') do
      expect(page).to have_field(:name)
      expect(page).to have_field(:address)
      expect(page).to have_field(:city)
      expect(page).to have_field(:state)
      expect(page).to have_field(:zip)
      expect(page).to have_button('Create Shelter')
    end
  end

  it 'can create a new shelter' do
    visit '/shelters/new'

    within('.new_shelter_form') do
      fill_in :name, with: 'Humane Society of Utah'
      fill_in :address, with: '4242 S 300 W'
      fill_in :city, with: 'Murray'
      fill_in :state, with: 'UT'
      fill_in :zip, with: '84107'
      click_button('Create Shelter')
    end
    expect(current_path).to eql('/shelters')
    require 'pry'; binding.pry
    expect(page).to have_content(Shelter.last.name)
  end
end
