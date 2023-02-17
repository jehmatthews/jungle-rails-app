require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    described_class.new(
      first_name: "Jordan",
      last_name: "Matthews",
      email: "jehmatthews30@gmail.com",
      password: "password",
      password_confirmation: "password"
    )
  }

  describe 'Validations' do

    it "is valid with valid attributes" do
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to be_empty
    end

    it "is not valid without first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("First name can't be blank")
    end

    it "is not valid without last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Last name can't be blank")
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Email can't be blank")
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Password can't be blank")
    end

    it "is not valid without pasword confirmation" do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "is not valid when password and password_confirmation don't match" do
      subject.password_confirmation = "passwordword"
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "is not valid when email isn't unique (case insensitive)" do
      same_as_subject = User.create(
        first_name: "Test", 
        last_name: "Tester", 
        email: "JEHMATTHEWS30@gmail.com", 
        password: "password", 
        password_confirmation: "password"
      )
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Email has already been taken")
    end

    it "is not valid when password is shorter than 5 characters" do
      subject.password = "1234"
      subject.password_confirmation = "1234"
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end

    it "is valid when password is exactly 5 characters" do
      subject.password = "12345"
      subject.password_confirmation = "12345"
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to be_empty
    end
  end

  describe '.authenticate_with_credentials' do

    it "authenticates when credentials are valid" do
      subject.save!
      auth = User.authenticate_with_credentials(subject.email, subject.password)
      expect(auth).to eq subject
    end

    it "doesn't authenticate when email is incorrect" do
      subject.save!
      auth = User.authenticate_with_credentials("random@hotmail.com", subject.password)
      expect(auth).to eq nil
    end

    it "doesn't authenticate when password is incorrect" do
      subject.save!
      auth = User.authenticate_with_credentials(subject.email, "wrongo")
      expect(auth).to eq nil
    end

    it "authenticates when email is correct but contains whitespace around it" do
      subject.save!
      auth = User.authenticate_with_credentials("   " + subject.email + "  ", subject.password)
      expect(auth).to eq subject
    end

    it "authenticates when email is correct but in the wrong case" do
      subject.save!
      auth = User.authenticate_with_credentials("JeHmAtThEwS30@GmAiL.cOm", subject.password)
      expect(auth).to eq subject
    end
  end
end
