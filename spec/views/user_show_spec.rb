require_relative '../rails_helper'
# frozen_string_literal: true
# rubocop:disable Layout/LineLength

RSpec.describe 'index page', type: :system do
  before(:each) do
    @user = User.create(name: 'VITS', photo: 'https:123', bio: 'A software developer based in Kenya', posts_counter: 0)
    3.times do |a|
      @posts = Post.create(author_id: @user.id, title: "#{a} Post", text: 'hello', comments_counter: 0,
                           likes_counter: 0)
    end
  end
  context 'render user show page' do
    it 'show content in user' do
      visit user_path(@user)
      expect(page).to have_content(@user.name)
      expect(page).to have_content('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.')
      expect(page).to have_xpath("//img[@src='#{@user.photo}']")
      expect(page).to have_content(@user.posts_counter)
    end
    it 'show three posts' do
      visit user_path(@user)
      expect(page).to have_css('.post', count: 3)
    end
    it 'button for user posts' do
      visit user_path(@user)
      expect(page).to have_button 'See all posts'
    end
    it 'onclick redirect to posts show' do
      visit user_path(@user)
      click_link @posts.id, match: :first
      expect(page).to have_current_path("/users/#{@user.id}/posts/#{@posts.id}")
    end
    it 'onclick redirect to posts index' do
      visit user_path(@user)
      click_button 'See all posts'
      expect(page).to have_current_path("/users/#{@user.id}")
    end
  end
end
