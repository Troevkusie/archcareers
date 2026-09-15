class Employer::DashboardController < ApplicationController
  before_action :authenticate_employer!

  def show
  end
end
