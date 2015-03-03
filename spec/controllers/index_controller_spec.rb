describe IndexController, type: :controller do

  render_views

  context 'with anonymous user' do
    before do
      FactoryGirl.create(:administrator)
      FactoryGirl.create(:editor)
    end

    it 'should be a redirect to cas login page' do
      get :index
      expect(response).to redirect_to 'http://test.host/people/auth/cas'
    end

    it 'should allow health check from unauthenticated users' do
      get :health_check
      expect(response.status).to eq 200
    end

    it 'should allow unauthenticated user to see denied page' do
      get :denied
      expect(response.status).to eq 200
    end
  end

end
