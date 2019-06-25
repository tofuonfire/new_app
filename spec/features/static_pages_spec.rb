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
    before {visit root_path}

    scenario "has a correct home link " do
      click_link "#{website_name}"
      expect(page).to have_current_path("/")
      # expect(page).to have_selector 'h1', text: "Welcome to #{website_name}!"
    end

    # scenario "has a correct log-in link" do
    #   click_link "Log in"
    #   expect(page).to have_current_path("/users/log_in")
    #   expect(page).to have_selector 'h1', text: 'Log in'
    # end

  end

end