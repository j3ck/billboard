require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Home", type: :feature do

  before do
    @category = FactoryGirl.create(:category)
    @category1 = FactoryGirl.create(:category, name: "test category")
    @type = FactoryGirl.create(:type)
    @type1 = FactoryGirl.create(:type, name: "test type")
    @advert1 = FactoryGirl.create(:advert, title: 'A', state: 'published', updated_at: '2014-03-25 08:30:02', price: 1, category_id: @category1.id, type_id: @type1.id)
    @advert2 = FactoryGirl.create(:advert, title: 'B', state: 'published', updated_at: '2014-02-25 08:30:02', price: 3, category_id: @category.id, type_id: @type.id)
    @advert3 = FactoryGirl.create(:advert, title: 'C', state: 'published', updated_at: '2014-01-25 08:30:02', price: 2, category_id: @category.id, type_id: @type.id)
    visit root_path
  end

  it 'sort by title' do
    click_link 'Title'
    %w(1 2 3).each do |num|
      expect(page).to have_selector("div.container div:nth-child(#{num})", text: instance_variable_get("@advert#{num}").title)
    end
  end

  it 'sort by price' do
    click_link 'Price'
    expect(page).to have_selector("div.container div:nth-child(1)", text: @advert1.title)
    expect(page).to have_selector("div.container div:nth-child(2)", text: @advert3.title)
    expect(page).to have_selector("div.container div:nth-child(3)", text: @advert2.title)
  end

  it 'sort by published date' do
    click_link 'Published date'
    expect(page).to have_selector("div.container div:nth-child(1)", text: @advert3.title)
    expect(page).to have_selector("div.container div:nth-child(2)", text: @advert2.title)
    expect(page).to have_selector("div.container div:nth-child(3)", text: @advert1.title)
  end

  it 'search by title' do
    within("#advert_search") do
      fill_in 'q_title_or_description_cont', with: @advert1.title
    end
    click_button 'Search'
    expect(page).to have_content @advert1.title
  end

  it 'search by category' do
    within("#advert_search") do
      select(@category1.name, from: 'q_category_id_cont')
    end
    click_button 'Search'
    expect(page).to have_content @advert1.title
  end

  it 'search by type' do
    within("#advert_search") do
      select(@type1.name, from: 'q_type_id_cont')
    end
    click_button 'Search'
    expect(page).to have_content @advert1.title
  end
end
