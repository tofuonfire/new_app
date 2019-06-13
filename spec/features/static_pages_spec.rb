require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do

  # それぞれのページが正しいタイトルを持つ
  scenario "each page has a correct title" do
    visit root_path
    expect(page.title).to eq full_title
    visit about_path
    expect(page.title).to eq full_title("About")
  end

  describe "layout" do

    before do
      visit root_path
    end

    scenario "has a correct home link " do
      click_link "blogapp"
      expect(page).to have_current_path("/")
      expect(page).to have_selector 'h1', text: 'Welcome to blogapp!'
    end

    scenario "has a correct about link " do
      click_link "About"
      expect(page).to have_current_path("/about")
      expect(page).to have_selector 'h1', text: 'About'
    end

    # scenario "has a correct log-in link" do
    #   click_link "Log in"
    #   expect(page).to have_current_path("#")
    #   expect(page).to have_selector 'h1', text: 'Log in'
    # end

  end

end