require 'spec_helper'

feature 'playing the game of life' do
  scenario 'start a new game' do
    visit '/'

    expect(page).to have_content "Game of Life"

    fill_in "Grid Size", with: 10
    fill_in "Live Cells", with: 5
    click_button "New Game"

    expect(page).to have_content "0"
    expect(page).to have_content "1"
  end

  scenario 'starting a game with an invalid grid size' do
    visit '/'

    fill_in "Grid Size", with: 99
    fill_in "Live Cells", with: 1
    click_button "New Game"

    expect(page).to have_content "Grid size must be divisible by ten"
  end

  scenario 'starting a game with an invalid live cell count' do
    visit '/'

    fill_in "Grid Size", with: 10
    fill_in "Live Cells", with: 11
    click_button "New Game"

    expect(page).to have_content "Live cells must be less than grid size"
  end

  scenario 'advance a game' do
    visit '/'

    expect(page).to have_content "Game of Life"

    fill_in "Grid Size", with: 10
    fill_in "Live Cells", with: 1
    click_button "New Game"

    click_button "Advance"

    expect(page).to have_content "0"
    expect(page).to_not have_content "1"
  end
end