require 'spec_helper'

describe WakaruRelation do
	
	let(:wakaru_user) { FactoryGirl.create(:user) }
	let(:wakarareru_post) { FactoryGirl.create(:micropost, user: FactoryGirl.create(:user)) }
	let(:wakaru_relation) { wakaru_user.wakaru_relations.build(wakarareru_post_id: wakarareru_post.id) }

	subject { wakaru_relation }

	it { should be_valid }

	describe "wakaru method" do
		it { should respond_to(:wakarareru_post) }
		it { should respond_to(:wakaru_user) }
		its(:wakaru_user) { should eq wakaru_user }
		its(:wakarareru_post) { should eq wakarareru_post }
	end

	describe "user = nil" do
		before { wakaru_relation.wakaru_user_id = nil }
		it { should_not be_valid }
	end

	describe "micropost = nil" do
		before { wakaru_relation.wakarareru_post_id = nil }
		it { should_not be_valid }
	end
end
