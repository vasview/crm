class CompaniesController < ApplicationController
  include FilterDates

  before_action :set_filter_period, only: [:index, :filter]
  before_action :representative_params, only: [:create]

  def new
    @company = Company.new
    # @executive = @company.executives.build
    # @representative = @executive.build_representative
    @representative = @company.representatives.build
  end

  def index
    @companies = Company.filter(entry_date: @filter_period)
                        .or(Company.filter(exit_date: @filter_period))
                        .order('name ASC')
                        .paginate(page: params[:page])

    @active_companies = Company.status('active').size
    @inactive_companies = Company.status('inactive').size
    @corporate_members = helpers.get_corporate_members
    @associates_members = helpers.get_accossiates_members
    @honarable_members = helpers.get_honarable_members
  end

  def show
    @company = Company.find(params[:id])
    @executive = @company.executives.first
    @representative = @executive.representative
  end

  def create
    @companyform = CompanyForm.new
    @companyform.validate(company_params.merge(representative_params))

    if @companyform.errors.empty?
      @company = Company.create(company_params)
      @representative = Representative.create(representative_params.merge(company_id: @company.id, company_head: true))
      @executive = Executive.create(company_id: @company.id, representative_id: @representative.id)

      flash[:notice] = "Карточка компания успешно добавлена."

      redirect_to companies_path
    else
      render :new , locals: { errors: @companyform.errors.messages }
    end
  end

  def edit
    @company = Company.find(params[:id])
    @executive = Executive.where(company_id: @company.id)
    @representative = Representative.find(@company.executives.first.representative_id)
  end

  def update
    @company = Company.find(params[:id])
    @executive = @company.executives.first
    @representative = @executive.representative

    @companyform = CompanyForm.new
    @companyform.validate(company_params.merge(representative_params))

    if @companyform.errors.empty?
      @company.update_attributes(company_params)
      @representative.update_attributes(representative_params)

      flash[:notice] = "Карточка компании успешно обновлена."
      redirect_to company_path(@company)
    else
      render :edit, locals: { errors: @companyform.errors.messages }
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    redirect_to companies_path, notice: "Карточка компании успешно удалена."
  end

  def filter
    @companies = Company.filter(entry_date: @filter_period)
                        .or(Company.filter(exit_date: @filter_period))
                        .order('name ASC')
                        .filter(params[:filter].slice(:category, :status))
                        .paginate(page: params[:page])

    respond_to do |format|
      format.js
    end
  end

  def update_company_options
    @company_selection = company_selection

    render partial: 'company_selection'
  end

  private

  def set_filter_period
    return @filter_period = get_filtered_period(filter_params, "from_very_beginning") if params[:filter].nil?

    if params[:filter][:date].present?
      @filter_period = get_filtered_period(filter_params)
    else
      @filter_period = get_filtered_period(filter_params, "from_very_beginning")
    end
  end

  def company_params
    params.require(:company).permit(:id, :name, :address,
                                    :work_phone, :mobile_phone,
                                    :email, :birthdate, :status,
                                    :category_id, :industry_id,
                                    :city_id, :entry_date,
                                    :exit_date, :exit_reason, :notes,
 )
  end

  def representative_params
    rep_params = []
    rep_params = params[:company].require(:representative).permit(:firstname, :middlename,
                                                                  :lastname, :job_position_id)
    rep_params[:fullname] = helpers.representative_fullname(params[:company][:representative].slice(:firstname, :middlename, :lastname))
    rep_params
  end

  def filter_params
    return { period: '' } if params[:filter].nil?
    params.require(:filter).permit(:category, :date, :period, :status)
  end

  def company_selection
    return Company.where(category_id: params[:id]) if params[:id].present?
    Company.status('active')
  end
end
