require 'rails_helper'
require 'monkeypatch'

RSpec.describe Movie, type: :model do
    
    describe "match director" do
        it "should return all movies that have same director and not return movies with different directors" do
            test1 = Movie.create! :director => "A B"
            test2 = Movie.create! :director => "C D"
            expect(Movie.match_dire('A B')).to include(test1)
            expect(Movie.match_dire('A B')).to_not include(test2)
        end
    end
    
    describe "get all ratings" do
        it 'returns all ratings' do
            expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
        end
    end
end
