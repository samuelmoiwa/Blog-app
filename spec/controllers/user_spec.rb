require_relative '../rails_helper'
RSpec.describe 'User', type: :request do
  describe 'User Show' do
    before(:each) do
      @user = User.create(name: 'VITS', photo: 'https:123', bio: 'A software developer based in Kenya', posts_counter: 0)
      @post = Post.create(author_id: @user.id, title: "title", text: 'hello', comments_counter: 0,
        likes_counter: 0)
      end
      context 'find responce check' do
        before(:example) { get '/' }
        it 'expect response to be :ok' do
          expect(response).to have_http_status(:ok)
        end
        it 'expect response with users:id' do
          get "/users/#{@user.id}"
          expect(response).to have_http_status(:ok)
        end
      end
      context "the controller#action renders template" do
        it "expect to render default template" do
          get "/"
          expect(response).to render_template("index")
        end
        it "expect to render default template" do
          get "/users/#{@user.id}"
          expect(response).to render_template('show')
        end
      end
  end
end
