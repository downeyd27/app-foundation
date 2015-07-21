require 'rails_helper'

RSpec.describe "UserPages", type: :feature do

  describe "signup page" do
    before { visit signup_path }
    let(:submit) { "Create my account"}

    describe "with invalid information" do
      it "should not create user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { expect(page).to have_title 'Sign Up' }
        it { expect(page).to have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Test User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Password Confirmation", with: "foobar"
      end

      it "should create user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { expect(page).to have_title user.name }
        it { expect(page).to have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end

    it { expect(page).to have_title 'Sign Up'}
    it { expect(page).to have_selector('h1', text: 'Sign Up')}
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { expect(page).to have_title user.name }
    it { expect(page).to have_selector('h1', text: user.name) }
  end
end