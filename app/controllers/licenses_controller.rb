class LicensesController < ApplicationController
  before_action :set_software

  def new
    @license = License.new
  end

  def create
    @license = License.new(license_params)
    @license.software = @software
    @license.user = current_user

    if @license.save
      redirect_to my_licenses_path
    else
      flash[:error] = @license.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def license_params
    params.require(:license).permit(:start_at, :end_at)
  end

  def set_software
    @software = Software.find(params[:software_id])
  end

end
