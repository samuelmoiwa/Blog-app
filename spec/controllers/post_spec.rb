require_relative '../rails_helper'
RSpec.describe 'Posts', type: :request do
  context 'check if the status is success' do
    it 'expect status to be 200 success' do
      get '/users/1/posts'
      expect(response).to have_http_status(:ok)
    end
    it 'expect status to be 200 success' do
      get '/users/1/posts/2'
      expect(response).to have_http_status(:ok)
    end
  end
	@@ -22,13 +22,13 @@
    end
  end
  context 'should render page contents correctly' do
    # it 'expect page to have "here are all posts"' do
    #   get '/users/1/posts'
    #   expect(response.body).to include('here are all posts')
    # end
    # it 'expect page to have "here are the individual posts"' do
    #   get '/users/1/posts/1'
    #   expect(response.body).to include('here are the individual posts')
    # end
  end
end
