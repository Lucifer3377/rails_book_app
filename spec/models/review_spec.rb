require "rails_helper"
RSpec.describe Author, :type => :model do
  context 'validation tests' do

        let(:author_review) {build(:random_author_review) }
        let(:book_review) {build(:random_book_review) }

        #user = build(:user)
        #Author review

        it "ensures author reviewer name presence" do
            author_review.name = nil
            expect(author_review.save).to eq(false)
        end

        it "ensures author reviewer rating presence" do
            author_review.star_rate = nil
            expect(author_review.save).to eq(false)
        end

        it "ensures author review title presence" do
            author_review.title = nil
            expect(author_review.save).to eq(false)
        end

        it "ensures author review description presence" do
            author_review.desc = nil
            expect(author_review.save).to eq(false)
        end

        it "for author review should save successfully" do
            expect(author_review.save).to eq(true)
        end

        #Book review

        it "ensures book reviewer name presence" do
            book_review.name = nil
            expect(book_review.save).to eq(false)
        end

        it "ensures book reviewer rating presence" do
            book_review.star_rate = nil
            expect(book_review.save).to eq(false)
        end

        it "ensures book review title presence" do
            book_review.title = nil
            expect(book_review.save).to eq(false)
        end

        it "ensures book review description presence" do
            book_review.desc = nil
            expect(book_review.save).to eq(false)
        end

        it "for book review should save successfully" do
            expect(book_review.save).to eq(true)
        end
    end
end