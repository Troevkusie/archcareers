require "test_helper"

class EmployerLogoutTest < ActionDispatch::IntegrationTest
  test "employer can log out" do
    post auth_employer_registration_path, params: {
      employer: {
        email: "logout_employer@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }

    assert cookies[:session_token].present?

    assert_difference "Session.count", -1 do
      delete auth_employer_session_path
    end

    assert_redirected_to root_path
  end

  test "employer cannot access dashboard after logging out" do
    post auth_employer_registration_path, params: {
      employer: {
        email: "logout_employer2@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }

    delete auth_employer_session_path

    get employer_dashboard_path
    assert_redirected_to new_auth_employer_session_path
  end
end
