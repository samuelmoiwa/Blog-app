require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher', posts_counter: 1)
    @post = Post.new(title: 'Hi', text: 'My world', comments_counter: 0, likes_counter: 0, author_id: 1)
  end

  it 'checks title presence' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'checks validation for comments counter' do
    @post.comments_counter = nil
    expect(@post).to_not be_valid
  end

  it 'checks if author id is present' do
    @post.author_id = nil
    expect(@post).to_not be_valid
  end

  it 'checks if comments counter is an integer' do
    @post.comments_counter = 'hey'
    expect(@post).to_not be_valid
  end

  it 'checks if likes counter is an integer' do
    @post.likes_counter = 'hello'
    expect(@post).to_not be_valid
  end

  describe 'Check methods in post' do
    before(:each) do
      @user1 = User.create(name: 'Tom', photo: 'photo', bio: 'Teacher', posts_counter: 0,id: 1)
      @post1 = Post.create(title: 'Hi', text: 'My world', comments_counter: 0, likes_counter: 0,
                           author_id: 1, id: 1)
      6.times do
        Comment.create(post: @post1, author: @user1, author_id: 1, text: 'In this life')
      end
    end

    it 'should return an array of five' do
      expect(@post1.five_recent_comments.count).to eql(5)
    end

    it 'should have the five recent comments method' do
      expect(@post).to respond_to(:five_recent_comments)
    end

    it 'should not return an empty array' do
      expect(@post1.five_recent_comments.count).to_not eql(0)
    end
  end
end
