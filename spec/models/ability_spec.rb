describe Ability do
  let(:user) { FactoryGirl.create(:person) }

  subject { Ability.new user }

  shared_examples 'a user' do
    it 'has a baseline of minimal rights' do
      expect(subject.can?(:access, :all)).to eq true
      expect(subject.can?(:dashboard, :all)).to eq true
      expect(subject.can?(:read, :all)).to eq true
    end
  end

  context 'non-privileged user' do
    it_behaves_like 'a user'
    it 'should not be able to manage anything' do
      expect(subject.can?(:manage, :all)).to eq false
    end
  end

  context 'administrative user' do
    let(:admin_role) { Role.create({role_id: Ability::ADMIN_ROLE_ID, name: 'Admin', description: 'Can manage all objects'}) }
    before do
      user.roles << admin_role
      user.save
    end
    it_behaves_like 'a user'
    it 'should be able to manage everything' do
      expect(subject.can?(:manage, :all)).to eq true
    end
  end

  context 'editorial user' do
    let(:editor_role) { Role.create({role_id: Ability::EDITOR_ROLE_ID, name: 'Editor', description: 'Can manage all objects except Person and Role'}) }
    before do
      user.roles << editor_role
      user.save
    end
    it_behaves_like 'a user'
    it 'should have editorial rights' do
      expect(subject.can?(:manage, :all)).to eq false
      expect(subject.can?(:manage, Person)).to eq false
      expect(subject.can?(:manage, Role)).to eq false
      expect(subject.can?(:manage, ActionType)).to eq true
    end
  end

end

