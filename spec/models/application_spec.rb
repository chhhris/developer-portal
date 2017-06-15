require 'spec_helper'

RSpec.describe Application, type: :model do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:key) }
  it { should validate_presence_of(:description) }

  context 'validates :key format' do
    it { should allow_value('foo-123').for(:key) }
    it { should allow_value('foo.bar').for(:key) }
    it { should allow_value('12345').for(:key) }
    it { should allow_value('AbCdE').for(:key) }
    it { should_not allow_values(['foo_1', 'foo 1', 'foo%bar', 'foo&bar']).for(:key) }
  end
end
