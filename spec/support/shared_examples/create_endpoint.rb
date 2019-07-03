RSpec.shared_examples 'a create endpoint' do |entity, action, required_field|
  let!(:entity_name) { entity.name.underscore.singularize }
  let(:create_request) { post action, params: params }

  context 'with required fields' do
    let(:attributes) { attributes_for(entity_name) }
    let(:params) { { entity_name => attributes } }

    it 'creates the new entity' do
      expect { create_request }.to(change { entity.count }.by(1))
    end
    it 'renders the new entity' do
      create_request
      expect(response_body).to eq(
        JSON[
          ActiveModelSerializers::SerializableResource.new(
            entity.first
          ).to_json
        ].symbolize_keys
      )
    end
    it 'responds with created' do
      create_request
      expect(response).to have_http_status(:created)
    end
  end

  context 'without required fields' do
    let(:params) { {} }

    it 'does not create the new entity' do
      expect { create_request }.not_to(change { entity.count })
    end
    it 'renders the missing fields' do
      create_request
      # TODO: add I18n to the error text
      expect(response_body).to eq(
        error: "param is missing or the value is empty: #{entity_name}"
      )
    end
    it 'renders bad request' do
      create_request
      expect(response).to have_http_status(:bad_request)
    end
  end

  context 'with invalid fields' do
    let(:params) do
      { entity_name => attributes_for(entity_name, required_field => '') }
    end

    it 'does not create the new entity' do
      expect { create_request }.not_to(change { entity.count })
    end
    it 'renders the errors' do
      create_request
      expect(response_body).to have_key(
        :errors
      )
    end
    it 'renders unprocessable entity' do
      create_request
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
