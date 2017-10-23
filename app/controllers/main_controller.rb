class MainController < ApplicationController
  include FilterDates

  def index
    @companies = Company.status('active').all

    set_filter_period

    score_companies(@companies)

    @corporate_members = get_corporate_members
    @associates_members = get_accossiates_members
    @honarable_members = get_honarable_members
  end

  def get_filtered_companies
    set_filter_period

    @companies = Company.status('active').filter(period: @filter_period).filter(params[:filter].slice(:category))

    score_companies(@companies)

    if color_filters.present?
     @companies = filter_by_colors(@companies, color_filters)
    end
  end

  private

  def set_filter_period
    @filter_period = get_filtered_period(filter_params)
  end

  def filter_params
    return {period: ''} if params[:filter].nil?
    params.require(:filter).permit(:category, :date, :period, colors: [])
  end

  def color_filters
    params[:filter][:colors]
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
    interaction_results = company.interaction_results.period(@filter_period)
    interaction_results.map{|result| marks << result.mark }
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
      total_corporate_members += Category.find(i).companies.filter(status: 'active').size
    end
    total_corporate_members
  end

  def get_accossiates_members
    associates_category_id = Category.where(title: 'Ассоциативный член').ids
    Category.find(associates_category_id.first).companies.filter(status: 'active').size
  end

  def get_honarable_members
    honorable_category_id = Category.where(title: 'Почетный член').ids
    Category.find(honorable_category_id.first).companies.filter(status: 'active').size
  end
end
