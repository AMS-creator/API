# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user) { build(:user) }
  let!(:image) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/kid.jpg", 'profile') }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password, image:)
  end

  # User signup test suite
  describe 'POST /signup' do
    context 'when invalid credential' do
      before { post '/signup', params: valid_attributes.to_json, headers: }
      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation erros' do
        expect(json['message']).to match(/Validation failed: Image can't be blank/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).to be_nil
      end
    end

    context 'when valid request' do
      before { post '/signup', params: valid_attributes, headers: }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank/i)
      end
    end
  end
end
