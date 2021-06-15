require 'rails_helper'
describe 'the posting process', type: :feature do
  before :each do
    User.create(email: 'user1@gmail.com', password: 'password', name: 'User1')
  end

  it 'creates a post' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user1@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit '/posts/'
    fill_in 'What\'s on your mind?', with: 'this is a content'
    click_button 'Post'
    expect(page).to have_text('Post was successfully created.')
  end

  it 'does not creates a post' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user1@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit '/posts/'
    fill_in 'What\'s on your mind?', with: ''
    click_button 'Post'
    expect(page).to have_text('Post could not be saved. Content can\'t be blank')
  end
end
