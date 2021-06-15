require 'rails_helper'
describe 'commenting process', type: :feature do
  before :each do
    User.create(email: 'user1@gmail.com', password: 'password', name: 'User1')
  end

  it 'Add a like' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user1@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit '/posts/'
    fill_in 'What\'s on your mind?', with: 'this is a content'
    click_button 'Post'
    fill_in 'Write a comment', with: 'This is a comment'
    click_button 'Send'
    expect(page).to have_text('Comment was successfully created.')
  end
end
