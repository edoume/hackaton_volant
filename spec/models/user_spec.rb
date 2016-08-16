require 'rails_helper'

describe User do
  before(:each) do
    @user = build(:user)
  end

  it "is valid with a firstname, lastname and email" do
    expect(@user).to be_valid
  end

  it "is invalid without a email" do
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do
    @user.password = nil
    @user.valid?
    expect(@user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    created_user = create(:user, email: @user.email)
    @user.valid?
    expect(@user.errors[:email]).to include("has already been taken")
  end
end