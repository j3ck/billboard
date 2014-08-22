require 'rails_helper'

describe Type, type: :model do

  subject{ FactoryGirl.build(:type}
  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:adverts) }

  it "is not valid if name is empty" do
    type = FactoryGirl.build(:type, name: nil)
    expect(type).not_to be_valid
  end

  it "is not valid if name is too long" do
    str = "a"*16
    type = FactoryGirl.build(:type, name: str)
    expect(type).not_to be_valid
  end
end
