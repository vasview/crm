class RepresentativesController < ApplicationController

  def new
    @representative = Representative.new
    @representative.committee_representatives.build
  end

  def index
    @representatives = Representative.order('fullname ASC')
                                     .paginate(page: params[:page])
  end

  def show
    @representative = Representative.find(params[:id])
  end

  def create
    @representative_form = RepresentativeForm.new
    @representative_form.validate(representative_params)

    if @representative_form.errors.empty?
      @representative = Representative.create(representative_params.merge(fullname: representative_fullname))

      save_representative_committee()

      redirect_to representatives_path, notice: "Карточка представителя компании успешно добавлена."
    else
      render :new, locals: { errors: @representative_form.errors.messages }
    end
  end

  def edit
    @representative = Representative.find(params[:id])
    if @representative.committee_representatives.present?
      committees = @representative.committee_representatives
      @committee_ids = committees.map { |c| c.committee_id }
    else
      @representative.committee_representatives.build
    end
  end

  def update
    @representative = Representative.find(params[:id])

    @representative_form = RepresentativeForm.new
    @representative_form.validate(representative_params)

    if @representative_form.errors.empty?
      @representative.committee_representatives.clear

      save_representative_committee()

      @representative.update_attributes(representative_params.merge(fullname: representative_fullname))

      redirect_to representative_path(@representative), notice: "Карточка представителя компании успешно отредактирована."
    else
      render :edit, locals: { errors: @representative_form.errors.messages }
    end
  end

  def destroy
    @representative = Representative.find(params[:id])

    @representative.destroy

    redirect_to representatives_path, notice: "Карточка представителя компании удалена."
  end

  def filter
    @representatives = Representative.filter(params[:filter].slice(:company, :job, :search))
                                     .order('fullname ASC')
                                     .paginate(page: params[:page])
    respond_to do |format|
      format.js
    end
  end

  def update_representative_options
    @representative_selection = Representative.where(company_id: params[:id])

    render partial: 'representative_selection'
  end

  private

  def representative_params
    params.require(:representative).permit(:id, :firstname, :middlename, :lastname,
                                           :work_phone, :mobile_phone, :email, :company_id,
                                           :job_position_id, :birthdate, :notes, :preferences
                                          )
  end

  def representative_fullname
    helpers.representative_fullname(representative_params.slice(:firstname, :middlename, :lastname))
  end

  def save_representative_committee
    representative_committees.map do |com_rep_id|
      @committee = @representative.committee_representatives.build(committee_id: com_rep_id)
      @committee.save
    end
  end

  def representative_committees_params
    params.require(:committee_representatives).permit(committee_ids: [])
  end

  def representative_committees
    representative_committees_params[:committee_ids].reject(&:blank?)
  end
end
