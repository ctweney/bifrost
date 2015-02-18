describe ApiController, type: :controller do

  render_views

  context 'with anonymous user' do
    it 'should be a redirect to /denied page' do
      get :apps
      expect(response).to redirect_to 'http://test.host/denied'
    end
  end

  context 'with a logged-in user' do
    login_user
    before do
      FactoryGirl.create(:application)
    end
    it 'should be a non-empty response on authenticated user' do
      get :apps
      expect(response.status).to eq 200
      json = JSON.parse response.body
      expect(json).to be
      expect(json[0]['application']['name']).to eq 'Test Application'
    end
  end

end
