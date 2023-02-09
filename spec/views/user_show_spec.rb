require_relative '../rails_helper'
# frozen_string_literal: true
# rubocop:disable Layout/LineLength

RSpec.describe 'index page', type: :system do
  describe 'User Show' do
    before(:each) do
      @user = User.create(name: 'VITS', photo: 'https:123', bio: 'A software developer based in Kenya', posts_counter: 0)
      @post = Post.create(author_id: @user.id, title: 'title', text: 'hello', comments_counter: 0,
                          likes_counter: 0)
      2.times do |a|
        Post.create(author_id: @user.id, title: "#{a} Post", text: 'hello', comments_counter: 0,
                    likes_counter: 0)
      end
      visit user_path(@user)
    end
    context 'render user show page' do
      it 'show  the user\'s username.' do
        expect(page).to have_content(@user.name)
        expect(page).to have_content('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.')
      end
      it 'show three posts' do
        expect(page).to have_css('.post', count: 3)
      end
      it 'button for user posts' do
        expect(page).to have_button 'See all posts'
      end
      it 'onclick redirect to posts show' do
        click_link @post.title, match: :first
        expect(page).to have_current_path(user_post_path(@user, @post))
      end
      it 'onclick redirect to posts index' do
        click_link 'See all posts'
        expect(page).to have_current_path(user_posts_path(@user))
      end
      it 'the user\'s profile picture' do
        expect(page).to have_xpath("//img[@src='#{@user.photo}']")
      end
      it 'the number of posts the user has written.' do
        expect(page).to have_content(@user.posts_counter)
      end
    end
  end
  # rubocop:enable Layout/LineLength
end
