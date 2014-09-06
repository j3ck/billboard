require 'rails_helper'

describe Category, type: :model do

  subject{ FactoryGirl.build(:category)}
  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:adverts) }

  it "is not valid if name is empty" do
    category = FactoryGirl.build(:category, name: nil)
    expect(category).not_to be_valid
  end

  it "is not valid if name is too long" do
    str = "a"*51
    category = FactoryGirl.build(:category, name: str)
    expect(category).not_to be_valid
  end
end
