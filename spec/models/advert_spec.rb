require 'rails_helper'

describe Advert do

  subject { FactoryGirl.build(:advert) }
  it { should be_valid }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }
  it { should respond_to(:images) }
  it { should respond_to(:user) }
  it { should respond_to(:category) }
  it { should respond_to(:type) }
  it { should respond_to(:state) }

  it 'is not valid if title is empty' do
    advert = FactoryGirl.build(:advert, title: nil)
    expect(advert).not_to be_valid
  end

  it 'is not valid if title is too long' do
    str = 'a' * 101
    advert = FactoryGirl.build(:advert, title: str)
    expect(advert).not_to be_valid
  end

  it 'is not valid if description is empty' do
    advert = FactoryGirl.build(:advert, description: nil)
    expect(advert).not_to be_valid
  end

  it 'is not valid if price is empty' do
    advert = FactoryGirl.build(:advert, price: nil)
    expect(advert).not_to be_valid
  end
end
