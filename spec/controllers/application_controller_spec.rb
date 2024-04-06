# frozen_string_literal: true

require 'rails_helper'

describe ApplicationController, type: :request do
  shared_examples 'visiting unconnected_user url' do
    context 'when visiting unconnected_user url' do
      it 'stays at unconnected_user' do
        get '/'

        expect(response.request.fullpath).to eq('/')
      end
    end
  end

  context 'when user not logged-in' do
    context 'when visiting connected_user url' do
      it 'redirects to unconnected_user' do
        get '/connected_user'

        expect(response).to redirect_to('/')
      end
    end

    include_examples 'visiting unconnected_user url'
  end

  context 'when user logged-in' do
    let(:user) { create(:user) }

    before { login(user) }

    context 'when visiting connected_user url' do
      it 'stay at connected_user' do
        get '/connected_user'

        expect(response.request.fullpath).to eq('/connected_user')
      end
    end

    include_examples 'visiting websunconnected_userite url'
  end
end
