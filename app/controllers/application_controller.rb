class ApplicationController < ActionController::Base
  before_action :set_current_session

  private

  def set_current_session
    if (token = cookies.signed[:session_token])
      Current.session = Session.find_by(token: token)
    end  
  end

  def authenticate_candidate!
    unless Current.candidate
      redirect_to new_auth_candidate_session_path, alert: "Войдите в аккаунт"
    end
  end

  def authenticate_employer!
    unless Current.employer
      redirect_to new_auth_employer_session_path, alert: "Войдите в аккаунт"
    end
  end

  def start_new_session_for(user)
    session_record = user.sessions.create!(
      user_agent: request.user_agent,
      ip_address: request.remote_ip
    )
    Current.session = session_record
    cookies.signed.permanent[:session_token] = {
      value: session_record.token,
      httponly: true,
      same_site: :lax
    }
  end

  def terminate_session
    Current.session&.destroy
    cookies.delete(:session_token)
  end
end
