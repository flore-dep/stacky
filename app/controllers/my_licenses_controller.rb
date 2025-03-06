class MyLicensesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @licenses = License.where(user_id: current_user.id).includes(:software)
    @licenses_active = License.active_license_per_user(current_user.id).includes(:software)
    @licenses_past = License.past_license_per_user(current_user.id).includes(:software)
  end
end
