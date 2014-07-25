require 'spec_helper'

feature 'playing the game of life' do
  scenario 'generate a custom grid', js: true do
    visit '/'

    fill_in "Rows", with: 1
    fill_in "Columns", with: 1

    within "span.cell" do
      expect(page).to have_content "0"
    end

    page.find("span.cell", :text => "0").click

    within "span.cell" do
      expect(page).to have_content "1"
    end
  end

  scenario 'start a new game', js: true do
    visit '/'

    fill_in "Rows", with: 2
    fill_in "Columns", with: 2

    page.first("span.cell", :text => "0").click

    click_button "Start Game"

    expect(page).to_not have_content "Rows"
    expect(page).to_not have_content "Columns"

    expect(page).to have_content "0"
    expect(page).to have_content "1"
  end

  scenario 'the game automatically advances after starting', js: true do
    visit '/'

    expect(page).to have_content "Game of Life"

    fill_in "Rows", with: 1
    fill_in "Columns", with: 1

    page.first("span.cell", :text => "0").click

    click_button "Start Game"

    expect(page).to have_content "1"

    click_button "Start"

    sleep(1)

    expect(page).to have_content "0"
    expect(page).to_not have_content "1"
  end
end