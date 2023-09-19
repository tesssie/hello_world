# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

RSpec.describe 'HelloController' do
  describe 'GET #hello' do
    it 'returns a hello message in JSON format' do
      get :hello
      json_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json_response['message']).to eq('hello')
    end
  end
end
