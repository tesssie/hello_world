require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'renders a list of users' do
      user1 = User.create(name: 'John', email: 'john@example.com')
      user2 = User.create(name: 'Jane', email: 'jane@example.com')

      get index
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(JSON.parse(response.body)['users'].length).to eq(2)
    end
  end

  describe 'GET #show' do
    it 'renders a user' do
      user = User.create(name: 'John', email: 'john@example.com')

      get show, params: { id: user.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(JSON.parse(response.body)['name']).to eq('John')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        post :create, params: { user: { name: 'John', email: 'john@example.com' } }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['name']).to eq('John')
      end
    end

    context 'with invalid parameters' do
      it 'returns errors' do
        post :create, params: { user: { name: '', email: 'john@example.com' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['errors'][0]).to eq("Name can't be blank")
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the user' do
        user = User.create(name: 'John', email: 'john@example.com')

        patch :update, params: { id: user.id, user: { name: 'John Doe' } }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['name']).to eq('John Doe')
      end
    end

    context 'with invalid parameters' do
      it 'returns errors' do
        user = User.create(name: 'John', email: 'john@example.com')

        patch :update, params: { id: user.id, user: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['errors'][0]).to eq("Name can't be blank")
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      user = User.create(name: 'John', email: 'john@example.com')

      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(:no_content)
      expect(User.count).to eq(0)
    end
  end
end