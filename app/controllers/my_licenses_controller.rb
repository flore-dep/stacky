class MyLicensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @licenses = License.where(user_id: current_user.id).includes(:software)
    # @softwares = @licenses.map { |license| license.software.id}
    # @software_licenses = Software.where(id: @softwares)
    # hehe
  end
  
end
