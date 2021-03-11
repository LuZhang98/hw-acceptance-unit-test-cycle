require 'rails_helper'
require 'monkeypatch'

RSpec.describe MoviesController do

    describe "GET #show" do
        let!(:movie) {Movie.create!({:title => "A", :rating => "G", :description => "lol", :release_date => "1000-10-10 00:00:00", :director => "B C"})}
        before(:each) do
            get :show, :id => movie.id
        end
        it "should find the test movie" do
            expect(assigns(:movie)).to eq(movie)
        end
        
        it "should render show template" do
            expect(response).to render_template('show')
        end
    end  
    
    describe "GET #index" do
        it "should render index template" do
            get :index
            expect(response).to render_template('index')
        end
        it "should have instance variable for title_header" do
            get :index, :sort => 'title'
            expect(assigns(:title_header)).to eq('bg-warning hilite')
        end
        it "should have instance variable for release_date" do
            get :index, :sort => 'release_date'
            expect(assigns(:date_header)).to eq('bg-warning hilite')
        end
    end
    
    describe "GET #new" do
        let!(:movie) {Movie.new}
        it "should render new template" do
            get :new
            expect(response).to render_template('new')
        end
    end
    
    describe "POST #create" do
        it "should post new test movie" do
            post :create, :movie => {:title => "A", :rating => "G", :description => "lol", :release_date => "1000-10-10 00:00:00", :director => "B C"}
            expect(Movie).to redirect_to movies_path
        end
    end
    
    describe "GET #edit" do
        let!(:movie) {Movie.create!({:title => "A", :rating => "G", :description => "lol", :release_date => "1000-10-10 00:00:00", :director => "B C"})}
        it "should render edit template" do
            get :edit, :id => movie.id
            expect(response).to render_template('edit')
        end
    end
    
    describe "PATCH #update" do
        let!(:movie) {Movie.create!({:title => "A", :rating => "G", :description => "lol", :release_date => "1000-10-10 00:00:00", :director => "B C"})}
        it "should patch update" do
            patch :update, :id => movie.id, :movie => {:title => "D", :rating => "R", :description => "dfsfsdf", :release_date => "1001-11-11 10:10:10", :director => "E F"}
            movie.reload
            expect(movie.title).to eq("D")
        end
    end
    
    describe "DELETE #destroy" do
        let!(:movie) {Movie.create!({:title => "A", :rating => "G", :description => "lol", :release_date => "1000-10-10 00:00:00", :director => "B C"})}
        it "should delete test movie" do
            delete :destroy, :id => movie.id
            expect(response).to redirect_to movies_path
        end
    end
    
    describe "GET #similar" do
        let!(:movie1) {Movie.create!({:title => "A", :rating => "G", :description => "lol", :release_date => "1000-10-10 00:00:00", :director => "B C"})}
        let!(:movie2) {Movie.create!({:title => "E", :rating => "R", :description => "losdfsdl", :release_date => "1020-3-16 03:20:30", :director => "B C"})}
        let!(:movie3) {Movie.create!({:title => "D", :rating => "R", :description => "dfsfsdf", :release_date => "1001-11-11 10:10:10"})}

        it "happy path, should find similar movies" do
            get :similar, :id => movie1.id
            expect(assigns(:similar)).to eq([movie1, movie2])
        end
        it "sad path, should go back to home page" do
            get:similar, :id => movie3.id
            expect(response).to redirect_to root_path
        end
    end

end
