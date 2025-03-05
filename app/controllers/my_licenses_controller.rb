class MyLicensesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @licenses = License.where(user_id: current_user.id).includes(:software)
    @licenses_active = License.active_license_per_user(current_user.id).includes(:software)
    @licenses_past = License.past_license_per_user(current_user.id).includes(:software)
    @softwares_active = @licenses_active.map { |license| license.software}
    @softwares_past = @licenses_past.map { |license| license.software}
  end
end
