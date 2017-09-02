class CompaniesController < ApplicationController
  def new
    @company = Company.new
    @executives = @company.executives.build
  end

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.create(company_params)
    if @company.save
      flash[:notice] = "Компания успешно добавлена"

      redirect_to companies_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def company_params
    params.require(:company).permit(:id, :name, :address,
                                    :work_phone, :mobile_phone,
                                    :email, :birthdate,
                                    :category_id, :industry_id,
                                    :city_id, :notes )
  end
end
