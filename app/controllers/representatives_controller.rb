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
    @representative = Representative.create(representative_params.merge(fullname: representative_fullname))
    if @representative.save

      redirect_to representatives_path, notice: "Карточка представителя компании успешно добавлен."
    else
      render :new
    end
  end

  def edit
    @representative = Representative.find(params[:id])
  end

  def update
    @representative = Representative.find(params[:id])

    if @representative.update_attributes(representative_params.merge(fullname: representative_fullname))

      redirect_to representative_path(@representative), notice: "Карточка представителя компании успешно отредактирована."
    else
      render :edit
    end
  end

  def destroy
    @representative = Representative.find(params[:id])

    @representative.destroy

    redirect_to representatives_path, notice: "Карточка представителя компании удалена."
  end

  private

  def representative_params
    params.require(:representative).permit(:id, :firstname, :middlename, :lastname,
                                           :work_phone, :mobile_phone, :email, :company_id,
                                           :job_position_id, :birthdate, :notes)
  end

  def representative_fullname
    [ params[:representative][:firstname],
      params[:representative][:middlename],
      params[:representative][:lastname] ].join(' ')
  end
end
