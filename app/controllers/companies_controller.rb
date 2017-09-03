class CompaniesController < ApplicationController
  def new
    @company = Company.new
    @executive = @company.executives.build
    @representative = @company.representatives.build
  end

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @executive = Executive.where(company_id: @company.id)
    @representative = Representative.find(@company.executives.first.representative_id)
  end

  def create
    # binding.pry
    @company = Company.create(company_params)
    if @company.save
      @representative = Representative.create(representative_params.merge(company_id: @company.id, company_head: true))
      @representative.save
      @executive = Executive.create(company_id: @company.id, representative_id: @representative.id)
      @executive.save

      flash[:notice] = "Карточка компания успешно добавлена"

      redirect_to companies_path
    else
      render :new
    end
  end

  def edit
    @company = Company.find(params[:id])
    @executive = Executive.where(company_id: @company.id)
    @representative = Representative.find(@company.executives.first.representative_id)
  end

  def update
    @company = Company.find(params[:id])
    @executive = Executive.where(company_id: @company.id)
    @representative = Representative.find(@company.executives.first.representative_id)

    if @company.update_attributes(company_params)
      @representative.update_attributes(representative_params)

      flash[:notice] = "Карточка компании успешно обновлена"
      redirect_to company_path(@company)
    else
      render :edit
    end
  end

  def destroy
    @company = Company.find(params[:id])
  end

  private

  def company_params
    params.require(:company).permit(:id, :name, :address,
                                    :work_phone, :mobile_phone,
                                    :email, :birthdate,
                                    :category_id, :industry_id,
                                    :city_id, :notes)
  end

  def representative_params
    params.require(:company).permit(:executive).tap do |whitelisted|
      whitelisted[:fullname] = params[:company][:executive][:representative][:fullname]
      whitelisted[:job_position_id] = params[:company][:executive][:representative][:job_position_id]
    end
  end
end
