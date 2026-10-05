require "test_helper"

class CandidateLogoutTest < ActionDispatch::IntegrationTest
  test "candidate can log out successfully" do
    post auth_candidate_registration_path, params: {
      candidate: {
        email: "logout_candidate@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }

    assert cookies[:session_token].present?

    assert_difference "Session.count", -1 do
      delete auth_candidate_session_path
    end
    assert_redirected_to root_path
  end


  test "candidate cannot access dashboard after logging out" do
    post auth_candidate_registration_path, params: {
      candidate: {
        email: "logout_candidate2@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }

    delete auth_candidate_session_path

    get candidate_dashboard_path
    assert_redirected_to new_auth_candidate_session_path
  end
end
