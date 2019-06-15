require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without a name" do
    @user = FactoryBot.build(:user, name: nil)
    @user.save
    expect(@user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a email" do
    @user = FactoryBot.build(:user, email: nil)
    @user.save
    expect(@user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with too long name" do
    @user = FactoryBot.build(:user, name: "a" * 51)
    @user.save
    expect(@user.errors[:name]).to include("is too long (maximum is 50 characters)")
  end

  it "is invalid with a duplicate email address" do
    duplicate_user = FactoryBot.create(:user, email: "user@example.com")
    user = FactoryBot.build(:user, email: duplicate_user.email.upcase)
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "saves email addresses as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    user = FactoryBot.create(:user, email: mixed_case_email)
    expect(user.reload.email).to eq mixed_case_email.downcase
  end

  it "is invalid with a blank password" do
    user = FactoryBot.build(:user, password: " " * 6)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with a password less than 6 characters" do
    user = FactoryBot.build(:user, password: "a" * 5)
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end
  
end
