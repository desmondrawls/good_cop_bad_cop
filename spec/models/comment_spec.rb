require 'spec_helper'

describe Comment do
	describe 'validations' do
		it { should validate_presence_of(:title) }
		it { should validate_presence_of(:text) }
		it { should validate_presence_of(:author) }
	end
end