class MyLicensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @licenses_active = License.where("end_at < ? AND user_id = ?", Time.current, current_user.id)
    @licenses_past = License.where(user_id: current_user.id)
    @softwares = @licenses.map { |license| license.software.id}
    @software_licenses = Software.where(id: @softwares)
  end
end
