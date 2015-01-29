describe Person do
  describe '#from_omniauth' do
    before {
      create(:person)
    }
    let(:auth) {
      auth = OpenStruct.new
      auth.uid = '1234'
      auth
    }
    subject { Person.from_omniauth(auth) }
    it 'gets a Person' do
      expect(subject).to be
      expect(subject.name).to eq 'Test User'
    end
  end
end
