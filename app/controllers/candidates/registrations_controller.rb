class Candidates::RegistrationsController < ApplicationController
  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      start_new_session_for(@candidate)
      redirect_to candidate_dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(:email, :password, :password_confirmation)
  end
end
