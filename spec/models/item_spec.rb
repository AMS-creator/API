require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should validate_presence_of(:contact) }
  it { should validate_presence_of(:price) }
  it { should have_many(:favorites).dependent(:destroy) }
  it { should validate_presence_of(:description) }
end
