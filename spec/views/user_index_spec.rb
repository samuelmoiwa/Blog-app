require_relative '../rails_helper'
RSpec.describe 'index page', type: :system do
  before(:each) do
    @user = User.create(name: 'VITS', photo: 'https:123', bio: 'A software developer based in Kenya', posts_counter: 0)
    3.times do |a|
      @user.posts.create(author_id: @user.id, title: "#{a} Post")
    end
  end
  context 'RENDER USER INDEX' do
    it 'show all content' do
      visit root_path
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.posts_counter)
      expect(page).to have_xpath("//img[@src='#{@user.photo}']")
    end
    it 'redirect to show' do
      visit root_path
      click_link @user.name, match: :first
      expect(page).to have_current_path(root_path(@user))
    end
  end
end
