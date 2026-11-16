require "application_system_test_case"

class CandidateRegistrationSystemTest < ApplicationSystemTestCase
  test "candidate registers through the browser" do
    visit root_path
    click_on "Ищу работу"

    fill_in "candidate_email", with: "new@example.com"
    fill_in "candidate_password", with: "password123"
    fill_in "candidate_password_confirmation", with: "password123"
    click_on "Зарегистрироваться"

    assert_text "Личный кабинет соискателя"
  end
end
