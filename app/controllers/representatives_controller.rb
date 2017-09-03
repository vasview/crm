class RepresentativesController < ApplicationController

  def new
    @representative = Representative.new
  end

  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find(params[:id])
  end

  def create
    binding.pry
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def representative_params
    params.require(:representative).permit(:id, :firstname, :middlename, :lastname,
                                           :work_phone, :mobile_phone, :email, :company_id,
                                           :job_position_id, :birthdate, :notes)
  end
end
