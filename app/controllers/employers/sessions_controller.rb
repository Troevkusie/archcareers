class Employers::SessionsController < ApplicationController
  def new
  end

  def create
    employer = Employer.find_by(email: params[:email]&.downcase&.strip)
    if employer&.authenticate(params[:password])
      start_new_session_for(employer)
      redirect_to employer_dashboard_path
    else
      flash.now[:alert] = "Неверный email или пароль"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    terminate_session
    redirect_to root_path
  end
end