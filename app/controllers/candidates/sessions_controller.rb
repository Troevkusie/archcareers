class Candidates::SessionsController < ApplicationController
  def new
  end

  def create
    candidate = Candidate.find_by(email: params[:email]&.downcase&.strip)
    if candidate&.authenticate(params[:password])
      start_new_session_for(candidate)
      redirect_to candidate_dashboard_path
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