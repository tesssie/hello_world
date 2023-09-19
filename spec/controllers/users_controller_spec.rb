require 'rails_helper'

RSpec.describe UsersController do
  describe 'GET #index' do
    it 'renders a list of users' do
      user1 = User.create(name: 'John', email: 'john@example.com')
      user2 = User.create(name: 'Jane', email: 'jane@example.com')

      get :index
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(JSON.parse(response.body)['users'].length).to eq(2)
    end
  end

  describe 'GET #show' do
    it 'renders a user' do
      user = User.create(name: 'John', email: 'john@example.com')

      get :show, { id: user.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(JSON.parse(response.body)['id']).to eq(user.id)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {

          post :create, user: { name: 'John', email: 'john@example.com' }
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the user' do
        user = User.create(name: 'John', email: 'john@example.com')

        patch :update, {id: user.id, user:  { name: 'John', email: 'john@example.com' } }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      user = User.create(name: 'John', email: 'john@example.com')

      delete :destroy,{ id: user.id }
      expect(response).to have_http_status(:no_content)
      expect(User.count).to eq(0)
    end
  end
end