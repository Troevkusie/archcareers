require "test_helper"

class Candidates::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "candidate can register with valid data" do
    assert_difference "Candidate.count", 1 do
      post auth_candidate_registration_path, params: {
        candidate: {
          email: "new_candidate@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_redirected_to candidate_dashboard_path
    assert cookies[:session_token].present?
  end

  test "candidate cannot register with invalid data" do
    assert_no_difference "Candidate.count" do
      post auth_candidate_registration_path, params: {
        candidate: {
          email: "not-an-email",
          password: "short",
          password_confirmation: "short"
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "candidate cannot register with an email that is already taken" do
    existing_email = candidates(:one).email

    assert_no_difference "Candidate.count" do
      post auth_candidate_registration_path, params: {
        candidate: {
          email: existing_email,
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_response :unprocessable_entity
  end
end
