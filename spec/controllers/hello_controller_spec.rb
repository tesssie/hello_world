# frozen_string_literal: true
#
require "rails_helper"

RSpec.describe HelloController  do


  describe 'GET #hello' do
    it 'returns a JSON response with a hello message' do
      get :hello
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ 'message' => 'Hello!' })
    end
  end
end
