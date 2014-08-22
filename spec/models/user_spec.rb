require 'rails_helper'

describe User, type: :model do

  subject{ FactoryGirl.build(:user}
  it { should be_valid }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:adverts) }

  it "is not valid if email is empty" do
    user = FactoryGirl.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "is not valid if password is empty" do
    user = FactoryGirl.build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it "is not valid if password_confirmation is empty" do
    user = FactoryGirl.build(:user, password_confirmation: nil)
    expect(user).not_to be_valid
  end
end
