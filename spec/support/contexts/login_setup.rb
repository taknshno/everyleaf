RSpec.shared_context "admin_login_setup" do
  before do
    visit new_session_path
    fill_in "session[email]", with: "steve@example.com"
    fill_in "session[password]", with: "12345678"
    click_button "ログインする"
    find(".close").click
  end
end

RSpec.shared_context "login_setup" do
  before do
    visit new_session_path
    fill_in "session[email]", with: "john@example.com"
    fill_in "session[password]", with: "12345678"
    click_button "ログインする"
    find(".close").click
  end
end