require "rails_helper"
RSpec.describe Book, :type => :model do
  context 'validation tests' do

        let(:book) {build(:random_book) }
        #user = build(:user)

        it "ensures out_of_stock presence" do
            book.author_id = nil
            expect(book.save).to eq(false)
        end

        it "ensures name presence" do
            book.name = nil
            expect(book.save).to eq(false)
        end

        it "ensures short description presence" do
            book.s_desc = nil
            expect(book.save).to eq(false)
        end

        it "ensures long description presence" do
            book.l_desc = nil
            expect(book.save).to eq(false)
        end

        # it "ensures Date of Production presence" do
        #     book.date_of_prod = nil
        #     expect(book.save).to eq(false)
        # end

        it "ensures price presence" do
            book.price = nil
            expect(book.save).to eq(false)
        end

        it "ensures genre presence" do
            book.genre = nil
            expect(book.save).to eq(false)
        end

        it "ensures out_of_stock presence" do
            book.out_of_stock = nil
            expect(book.save).to eq(false)
        end

        it "should save successfully" do
            expect(book.save).to eq(true)
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