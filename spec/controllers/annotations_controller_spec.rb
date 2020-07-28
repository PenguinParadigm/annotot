require 'spec_helper'

RSpec.describe Annotot::AnnotationsController, type: :controller do
  routes { Annotot::Engine.routes }
  let(:valid_attributes) do
    {
      uuid: 'abc-123-do-re-mi',
      canvas: 'http://www.example.com/canvas',
      data: 'super cool anno data'
    }
  end
  let(:invalid_attributes) do
    {
      uuid: ''
    }
  end

  describe 'GET index' do
    before do
      FactoryBot.create_list(:annotation, 2)
      FactoryBot.create(:annotation, canvas: 'http://www.example.com/bad')
      FactoryBot.create(:annotation, canvas: 'http://www.example.com/hola')
    end
    it 'returns annotations that have the correct canvas uri' do
      get :index, params: { uri: 'http://www.example.com/hola', format: :json }
      expect(response.status).to eq 200
      expect(assigns(:annotations).length).to eq 3
    end
    it 'requires uri parameter' do
      expect { get :index, params: { format: :json } }
        .to raise_error ActionController::ParameterMissing, /uri/
    end
  end
  describe 'GET lists' do
    before do
      FactoryBot.create_list(:annotation, 2)
      FactoryBot.create(:annotation, canvas: 'http://www.example.com/bad')
      FactoryBot.create(:annotation, canvas: 'http://www.example.com/hola')
    end
    it 'returns annotations that have the correct canvas uri' do
      get :lists, params: { uri: 'http://www.example.com/hola', format: :json }
      expect(response.status).to eq 200
      expect(assigns(:annotations).length).to eq 3
    end
    it 'requires uri parameter' do
      expect { get :lists, params: { format: :json } }
        .to raise_error ActionController::ParameterMissing, /uri/
    end
  end
  describe 'GET pages' do
    before do
      FactoryBot.create_list(:annotation, 2)
      FactoryBot.create(:annotation, canvas: 'http://www.example.com/bad')
      FactoryBot.create(:annotation, canvas: 'http://www.example.com/hola')
    end
    it 'returns annotations that have the correct canvas uri' do
      get :pages, params: { uri: 'http://www.example.com/hola', format: :json }
      expect(response.status).to eq 200
      expect(assigns(:annotations).length).to eq 3
    end
    it 'requires uri parameter' do
      expect { get :lists, params: { format: :json } }
        .to raise_error ActionController::ParameterMissing, /uri/
    end
  end
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Annotation' do
        expect do
          post :create, params: { format: :json, annotation: valid_attributes }
        end.to change(Annotot::Annotation, :count).by(1)
      end

      it 'assigns @annotation' do
        post :create, params: { format: :json, annotation: valid_attributes }
        expect(assigns(:annotation)).to be_a Annotot::Annotation
      end

      it 'returns persited annotation data' do
        post :create, params: { format: :json, annotation: valid_attributes }
        expect(response.body).to eq 'super cool anno data'
      end
    end

    context 'without required fields' do
      it 'responds with a 400' do
        post :create, params: { format: :json, annotation: invalid_attributes }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body))
          .to include('message' => 'An annotation could not be created')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested annotation by uuid' do
      annotation = FactoryBot.create :annotation
      expect do
        delete :destroy, params: { format: :json, id: annotation.uuid }
      end.to change(Annotot::Annotation, :count).by(-1)
    end

    it 'destroys the requested annotation by id' do
      annotation = FactoryBot.create :annotation
      expect do
        delete :destroy, params: { format: :json, id: annotation.id }
      end.to change(Annotot::Annotation, :count).by(-1)
    end

    it 'responds with accepted' do
      annotation = FactoryBot.create :annotation
      delete :destroy, params: { format: :json, id: annotation.to_param }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body))
        .to include('message' => 'Annotation was successfully destroyed.')
    end
  end
end
