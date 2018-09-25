require "rails_helper"
RSpec.describe Author, :type => :model do
  context 'validation tests' do

        let(:author) {build(:random_author) }
        #user = build(:user)

        it "ensures name presence" do
            author.name = nil
            expect(author.save).to eq(false)
        end

        it "ensures biography presence" do
            author.biography = nil
            expect(author.save).to eq(false)
        end

        it "ensures acdemics presence" do
            author.academics = nil
            expect(author.save).to eq(false)
        end

        it "ensures awards presence" do
            author.awards = nil
            expect(author.save).to eq(false)
        end

        it "ensures active presence" do
            author.active = nil
            expect(author.save).to eq(false)
        end

        it "should save successfully" do
            expect(author.save).to eq(true)
        end
    end
end