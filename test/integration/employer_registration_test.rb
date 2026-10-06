require "test_helper"

class Employers::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "employer can register with valid data" do
    assert_difference "Employer.count", 1 do
      post auth_employer_registration_path, params: {
        employer: {
          email: "new_employer@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_redirected_to employer_dashboard_path
    assert cookies[:session_token].present?
  end

  test "employer cannot register with invalid data" do
    assert_no_difference "Employer.count" do
      post auth_employer_registration_path, params: {
        employer: {
          email: "not-an-email",
          password: "short",
          password_confirmation: "short"
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "employer cannot register with an email that is already taken" do
    existing_email = employers(:one).email

    assert_no_difference "Employer.count" do
      post auth_employer_registration_path, params: {
        employer: {
          email: existing_email,
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_response :unprocessable_entity
  end
end
