module SpecHelperModule

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:person]
      user = FactoryGirl.create(:person)
      sign_in user
    end
  end

  def random_id
    rand(99999).to_s
  end

end
