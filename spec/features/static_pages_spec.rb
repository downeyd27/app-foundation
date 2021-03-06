

RSpec.describe "StaticPages", type: :feature do

  subject { page }

  it "should have the right links on the layout" do
    visit root_path

    click_link "Help"
    expect(page).to have_title full_title('Help')

    click_link "About"
    expect(page).to have_title full_title('About')

    click_link "Contact"
    expect(page).to have_title full_title('Contact')

    click_link "Home"
    expect(page).to have_title full_title('')

    click_link "logo"
    expect(page).to have_title full_title('')

    click_link "Sign up"
    expect(page).to have_title full_title('Sign up')
  end

  shared_examples_for "all static pages" do
    it { expect(page).to have_title full_title(page_title) }
    it { expect(page).to have_selector('h1', text: heading) }
  end

  describe "Home Page" do
    before { visit root_path }
    let(:heading) { 'Home Page' }
    let(:page_title) { '' }

    it_should_behave_like 'all static pages'
    it { expect(page).to_not have_title '| Home' }

    describe "for signed-in-users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dol or sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
      before do
          other_user.follow!(user)
          visit root_path
        end

        it { expect(page).to have_link("0 following", href: following_user_path(user)) }
        it { expect(page).to have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  describe "Help Page" do
    before { visit help_path }
    let(:heading) { 'Help Page' }
    let(:page_title) { 'Help' }

    it_should_behave_like 'all static pages'
  end

  describe "About Page" do
    before { visit about_path }
    let(:heading) { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like 'all static pages'
  end

  describe "Contact Page" do
    before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like 'all static pages'
  end
end
