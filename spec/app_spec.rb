require 'spec_helper'

feature 'playing the game of life' do
  scenario 'start a new game' do
    visit '/'

    expect(page).to have_content "Game of Life"

    fill_in "Grid Size", with: 4
    fill_in "Live Cells", with: 2
    click_button "New Game"

    expect(page).to have_content "0"
    expect(page).to have_content "1"
  end

  scenario 'advance a game' do
    visit '/'

    expect(page).to have_content "Game of Life"

    fill_in "Grid Size", with: 4
    fill_in "Live Cells", with: 1
    click_button "New Game"

    click_button "Advance"

    expect(page).to have_content "0"
    expect(page).to_not have_content "1"
  end
end