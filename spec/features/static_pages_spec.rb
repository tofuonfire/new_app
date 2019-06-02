require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  before do
    @base_title = " | NewApp"
  end

  scenario "home page has a correct title" do
    visit root_path
    expect(page.title).to eq "Home#{@base_title}"
  end

  scenario "help page has a correct title" do
    visit static_pages_help_url
    expect(page.title).to eq "Help#{@base_title}"
  end

  scenario "about page has a correct title" do
    visit static_pages_about_url
    expect(page.title).to eq "About#{@base_title}"
  end

  scenario "contact page has a correct title" do
    visit static_pages_contact_url
    expect(page.title).to eq "Contact#{@base_title}"
  end
end
