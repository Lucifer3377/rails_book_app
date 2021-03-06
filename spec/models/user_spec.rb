require "rails_helper"
RSpec.describe User, :type => :model do
  context 'validation tests' do

        let(:user) {build(:random_user) }
        #user = build(:user)

        it "ensures first name presence" do
            user.first_name = nil
            expect(user.save).to eq(false)
        end

        it "ensures last name presence" do
            user.last_name = nil
            expect(user.save).to eq(false)
        end

        it "ensures phone number presence" do
            user.phone = nil
            expect(user.save).to eq(false)
        end

        it "ensures email presence" do
            user.email = nil
            expect(user.save).to eq(false)
        end

        it "should save successfully" do
            expect(user.save).to eq(true)
        end

        # before(:all) do
        #     @user1 = create(:user)
        # end
        
        # it "is valid with valid attributes" do
        #     expect(@user1).to be_valid
        # end
        
        # it "has a unique username" do
        #     user2 = build(:user, email: "bob@gmail.com")
        #     expect(user2).to_not be_valid
        # end
        
        # it "has a unique email" do
        #     user2 = build(:user, username: "Bob")
        #     expect(user2).to_not be_valid
        # end
        
        # it "is not valid without a password" do 
        #     user2 = build(:user, password: nil)
        #     expect(user2).to_not be_valid
        # end
        
        # it "is not valid without a username" do 
        #     user2 = build(:user, username: nil)
        #     expect(user2).to_not be_valid
        # end
        
        # it "is not valid without an email" do
        #     user2 = build(:user, email: nil)
        #     expect(user2).to_not be_valid
        # end
    end
end