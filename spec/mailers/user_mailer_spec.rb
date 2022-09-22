RSpec.describe UserMailer, type: :mailer do
  describe 'daily weather update' do
    user = User.find_by(email: 'test@test.com')
    let(:mail) { UserMailer.subscribe(user) }
    result = Util.get_weather(name: user[:city])

    it 'renders the headers' do
      expect(mail.subject).to eq('Your daily weather update')
      expect(mail.to).to eq([user[:email]])
      expect(mail.from).to eq(['ose.ughu@outlook.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include result[:name], result[:weather]
    end
  end
end
