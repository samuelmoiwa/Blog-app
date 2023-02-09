require 'rails_helper'

RSpec.describe 'Post index page', type: :system do
  before do
    driven_by(:rack_test)

    @user = User.create(name: 'John', photo: 'https://kiddy.com/pic/890987655', bio: 'Hi there', posts_counter: 0)
    Post.create(title: 'Hello from Mars',
                text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.', comments_counter: 0, likes_counter: 0, author_id: @user.id) # rubocop:disable Layout/LineLength
    @post = Post.create(title: 'Hello from Earth', text: 'The printing and typesetting industry.',
                        comments_counter: 0, likes_counter: 0, author_id: @user.id)
    @comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Hello')

    visit user_posts_path(@user.id)
  end
  context 'When visiting the post index page' do # rubocop:disable Metrics/BlockLength
    it "should load the user's name" do
      expect(page).to have_content('John')
    end
    # rubocop:enable Metrics/BlockLength
    it 'should load the number of posts by the user' do
      expect(page).to have_content('Number of posts: 2')
    end

    it "should load the post's title" do
      expect(page).to have_content('Hello from Earth')
      expect(page).to have_content('Hello from Mars')
    end

    it 'should show posts bodies' do
      expect(page).to have_content(@post.text)
    end

    it 'should show posts last comments' do
      expect(page).to have_content(@comment.text)
    end

    it 'should show pagination' do
      expect(page).to have_content('Pagination')
    end
    it 'profile photo should be present' do
      visit user_posts_path(@user.id)
      expect(page).to have_xpath("//img[@src='#{@user.photo}']")
    end
    it 'Should  Show the first comment for each post ' do
      expect(page).to have_content(@comment.text)
    end
    it 'Should show how many likes on this post' do
      expect(page).to have_content('likes: 0')
    end
    it 'Should show a section for pagination if there are more posts than fit on the view' do
      expect(page).to have_content('Pagination')
    end
  end
end
