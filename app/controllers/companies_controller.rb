class CompaniesController < ApplicationController
 
  def new
    @company = Company.new
    @executive = @company.executives.build
    @representative = @executive.build_representative
  end

  def index
    @companies = Company.status('active').all

    score_companies(@companies)
    
    @corporate_members = get_corporate_members
    @associates_members = get_accossiates_members
    @honarable_members = get_honarable_members
  end

  def show
    @company = Company.find(params[:id])
    @executive = @company.executives.first
    @representative = @executive.representative
  end

  def create
    @company = Company.create(company_params)
    if @company.save
      @representative = Representative.create(representative_params.merge(company_id: @company.id, company_head: true))
      @representative.save
      @executive = Executive.create(company_id: @company.id, representative_id: @representative.id)
      @executive.save

      flash[:notice] = "Карточка компания успешно добавлена."

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
    @executive = @company.executives.first
    @representative = @executive.representative

    if @company.update_attributes(company_params)
      @representative.update_attributes(representative_params)

      flash[:notice] = "Карточка компании успешно обновлена."
      redirect_to company_path(@company)
    else
      render :edit
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    redirect_to companies_path, notice: "Карточка компании успешно удалена."
  end

  def get_filtered_companies
    filter_period = get_filtered_period

    @companies = Company.status('active').filter(period: filter_period).filter(params[:filter].slice(:category))
    
    score_companies(@companies)
    
    if color_filters.present? 
     @companies = filter_by_colors(@companies, color_filters)
    end
    
  end

  def get_filtered_period
    filtered_period = []

    case date_filter
      when '1-6 month'
        start_day = DateTime.now().beginning_of_year
        end_day = start_day + 6.month - 1.day
      when '6-12 month'
        end_day = DateTime.now().end_of_year
        start_day = end_day - 6.month + 1.day
      when '12 month'
        start_day = DateTime.now().beginning_of_year
        end_day = DateTime.now().end_of_year
      when 'period'
        period = period_filter.split(' - ')
        start_day = Date.parse(period.first)
        end_day = Date.parse(period.last)
      else
        start_day = default_start_day
        end_day = default_end_day
    end

    filtered_period = [start_day, end_day]
  end

  private

  def company_params
    params.require(:company).permit(:id, :name, :address,
                                    :work_phone, :mobile_phone,
                                    :email, :birthdate, :status,
                                    :category_id, :industry_id,
                                    :city_id, :notes)
  end

  def representative_params
    params.require(:company).permit(:executive).tap do |whitelisted|
      whitelisted[:fullname] = params[:company][:executive][:representative][:fullname]
      whitelisted[:job_position_id] = params[:company][:executive][:representative][:job_position_id]
    end
  end

  def filter_params
    params.require(:filter).permit(:category, :date, :period, colors: [])
  end

  def color_filters
    params[:filter][:colors]
  end

  def period_filter
    params[:filter][:period] 
  end

  def date_filter
    params[:filter][:date]
  end

  def default_end_day
    if DateTime.now().month <= 6
      end_day = DateTime.now().beginning_of_year + 6.month - 1.day
    else 
      end_day = DateTime.now().end_of_year
    end  
  end

  def default_start_day
    if DateTime.now().month <= 6
      start_day = DateTime.now().beginning_of_year
    else 
       start_day = DateTime.now().end_of_year - 6.month + 1.day
    end  
  end

  def score_companies(companies)
    companies.each do |company|
      company.total = get_scores(company)

      set_company_color(company)
    end
    companies
  end

  def get_scores(company)
    marks = []
    company.interaction_results.map{|result| marks << result.mark }
    total = marks.inject(0, :+)
  end

  def set_company_color(company)
    if company.total > 4
      company.color = "green"
    elsif company.total >= 1
      company.color = "yellow"
    else
      company.color = "red"
    end
  end

  def filter_by_colors(companies, colors)
    companies.select{ |company| colors.include?(company.color) }
  end

  def get_corporate_members
    total_corporate_members = 0
    (1..4).each do |i|
      total_corporate_members += Category.find(i).companies.size
    end
    total_corporate_members
  end

  def get_accossiates_members
    associates_category_id = Category.where(title: 'Ассоциативный член').ids
    Category.find(associates_category_id.first).companies.size
  end

  def get_honarable_members
    honorable_category_id = Category.where(title: 'Почетный член').ids
    Category.find(honorable_category_id.first).companies.size
  end
end
