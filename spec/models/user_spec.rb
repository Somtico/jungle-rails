require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save successfully with all fields present and matching password confirmation' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'should not save without a password' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: nil,
        password_confirmation: nil
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not save without password confirmation matching password' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'wrongpassword'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not save without email, first name, or last name' do
      user = User.new(
        email: nil,
        first_name: nil,
        last_name: nil,
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank", "First name can't be blank", "Last name can't be blank")
    end

    it 'should not allow duplicate emails (case insensitive)' do
      User.create!(
        email: 'TEST@EXAMPLE.COM',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      user = User.new(
        email: 'test@example.com',
        first_name: 'Jane',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'should validate minimum length of password' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'short',
        password_confirmation: 'short'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate with correct credentials' do
      user = User.create!(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'should not authenticate with incorrect credentials' do
      User.create!(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it 'should authenticate with email having leading and trailing spaces' do
      user = User.create!(
        email: ' test@example.com ',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'should authenticate with email in different case' do
      user = User.create!(
        email: 'TEST@EXAMPLE.COM',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end
