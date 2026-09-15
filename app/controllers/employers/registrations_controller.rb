class Employers::RegistrationsController < ApplicationController
  def new
    @employer = Employer.new
  end

  def create
    @employer = Employer.new(employer_params)
    if @employer.save
      start_new_session_for(@employer)
      redirect_to employer_dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def candidate_params
    params.require(:employer).permit(:email, :password, :password_confirmation)
  end
end
