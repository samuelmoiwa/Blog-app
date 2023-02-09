require 'rails_helper'

RSpec.describe 'Post show page', type: :system do
  before do
    driven_by(:rack_test)
    @user = User.create(name: 'John', photo: 'https://kiddy.com/pic/890987655', bio: 'Hi there', posts_counter: 0)
    @post = Post.create(title: 'Hello from Mars',
                        text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.', comments_counter: 0, likes_counter: 0, author_id: @user.id) # rubocop:disable Layout/LineLength
    @comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Hello')

    visit user_post_path(@user, @post)
  end

  context 'When visiting the post show page' do
    it "should display the post's title" do
      expect(page).to have_content(@post.title)
    end

    it "should display the author's name" do
      expect(page).to have_content('John')
    end

    it 'should display the number of comments' do
      expect(page).to have_content('Comments:1')
    end
    it 'should display the number of likes' do
      expect(page).to have_content('Likes: 0')
    end
    it "should display the post's body" do
      expect(page).to have_content(@post.text)
    end

    it 'should display the comments pusblished' do
        expect(page).to have_content('Hello')
        expect(page).to have_content('John')
    end
    it 'Should show  the username of each commentor.' do
      expect(page).to have_content('John: Hello')
    end
  end
end
