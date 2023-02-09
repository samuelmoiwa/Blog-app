require_relative '../rails_helper'
RSpec.describe 'Posts', type: :request do
  describe 'User Show' do
    before(:each) do
      @user = User.create(name: 'VITS', photo: 'https:123', bio: 'A software developer based in Kenya', posts_counter: 0)
      @post = Post.create(author_id: @user.id, title: "title", text: 'hello', comments_counter: 0,
        likes_counter: 0)
      end
      context 'check if the status is success' do
        it 'expect status to be 200 success' do
          get "/users/#{@user.id}/posts"
          expect(response).to have_http_status(:ok)
        end
        it 'expect status to be 200 success' do
          get "/users/#{@user.id}/posts/#{@post.id}"
          expect(response).to have_http_status(:ok)
        end
      end

      context 'should render template' do
        it 'expect users/1/posts to be rendered' do
          get "/users/#{@user.id}/posts"
          expect(response).to render_template('index')
        end
        it 'expect users/1/posts/:id to be rendered' do
          get "/users/#{@user.id}/posts/#{@user.id}"
          expect(response).to render_template('show')
        end
      end
  end
end
