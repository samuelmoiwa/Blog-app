require_relative '../rails_helper'
RSpec.describe 'index page', type: :system do
  describe 'User Index' do
    before(:each) do
      @user = User.create(name: 'VITS', photo: 'https:123', bio: 'A software developer based in Kenya',
                          posts_counter: 0)
      3.times do |a|
        Post.create(author_id: @user.id, title: "#{a} Post")
      end
      visit users_path
    end
    context 'RENDER USER INDEX' do
      it 'show all content' do
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user.posts_counter)
        expect(page).to have_xpath("//img[@src='#{@user.photo}']")
      end
      it 'redirect to show' do
        click_link @user.name, match: :first
        expect(page).to have_current_path(user_path(@user))
      end
      it 'Should show  the username of all other users' do
        expect(page).to have_content(@user.name)
      end
      it 'Should show the profile picture for each user. ' do
        expect(page).to have_xpath("//img[@src='#{@user.photo}']")
      end
    end
  end
end
