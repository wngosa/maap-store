RSpec.shared_examples 'a paginated request' do |entity|
  it 'renders the desired content on the current page' do
    expect(response_body[:items]).to eq(
      JSON[ActiveModelSerializers::SerializableResource.new(
        entity.page(
          response_body[:current_page]
        ).per(request.params[:per_page] || 100)
      ).to_json]
    )
  end

  it 'renders the desired current_page' do
    expect(response_body[:current_page]).to eq(
      request.params[:page] || 1
    )
  end

  it 'renders the desired total_pages' do
    expect(response_body[:total_pages]).to eq(
      entity.page(1).per(request.params[:per_page] || 100).total_pages
    )
  end

  it 'renders the desired per_page' do
    expect(response_body[:per_page]).to eq(request.params[:per_page] || 100)
  end

  it 'renders the desired total_count' do
    expect(response_body[:items].length).to eq(entity.count)
  end
end
