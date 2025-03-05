class MyLicensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @licenses_active = License.active_license_per_user(current_user.id)
    @licenses_past = License.past_license_per_user(current_user.id)
    @softwares_active = @licenses_active.map { |license| license.software}
    @softwares_past = @licenses_past.map { |license| license.software}
  end
end
