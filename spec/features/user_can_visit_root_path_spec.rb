require 'rails_helper'

describe "User can visit root path" do
  it "to see a search form" do
    visit '/'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Welcome to Poetry and Emotion')
    expect(page).to have_selector('input')
  end

  it 'can get first 10 poems by author' do 
    visit '/'
    fill_in "Enter Author Name", with: "Emily"
    click_on 'Get Poems'
    expect(current_path).to eq('/search')
    expect(page).to have_css('.poem-9')
    expect(page).to_not have_css('.poem-10')
    within '.poem-7' do
     expect(page).to have_css(".Title")
     expect(page).to have_css(".Author")
     expect(page).to have_css(".Lines")
     expect(page).to have_css(".Tone")
    end
  end
end
