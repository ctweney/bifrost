describe IndexController, type: :controller do

  render_views

  before do
    FactoryGirl.create(:administrator)
    FactoryGirl.create(:editor)
  end

  context 'with anonymous user' do
    it 'should be a redirect to cas login page' do
      get :index
      expect(response).to redirect_to 'http://test.host/people/auth/cas'
    end

    it 'should allow health check from unauthenticated users' do
      get :health_check
      expect(response.status).to eq 200
    end

    it 'should return 500 if the database is out' do
      allow(Role).to receive(:where) { raise ActiveRecord::StatementInvalid }
      get :health_check
      expect(response.status).to eq 500
    end

    it 'should allow unauthenticated user to see denied page' do
      get :denied
      expect(response.status).to eq 200
    end

    it 'should not allow server_info check to unauthenticated user' do
      get :server_info
      expect(response).to redirect_to 'http://test.host/people/auth/cas'
    end
  end

  context 'with logged-in user' do
    login_user

    it 'should show the admin page' do
      get :index
      expect(response).to redirect_to '/admin'
    end

    it 'should not allow server_info check to unprivileged user' do
      get :server_info
      expect(response).to redirect_to '/denied'
    end
  end

  context 'with logged-in administrative user' do
    login_administrator

    it 'should allow server_info check' do
      get :server_info
      json = JSON.parse response.body
      expect(json).to be
      expect(json['startup_time']).to be
      expect(json['hostname']).to be
      expect(json['git_commit']).to be
      expect(json['db_schema']).to eq '20150217225045'
    end
  end
end
