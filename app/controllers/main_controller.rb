class MainController < ApplicationController
  include FilterDates

  before_action :set_filter_period

  def index
    @companies = Company.status('active').all

    helpers.score_companies(@companies)

    @companies = helpers.get_scores_in_descending_order(@companies)

    @corporate_members = helpers.get_corporate_members
    @associates_members = helpers.get_accossiates_members
    @honarable_members = helpers.get_honarable_members
  end

  def filter_companies
    @companies = Company.status('active').filter(params[:filter].slice(:category))

    helpers.score_companies(@companies)

    @companies = helpers.get_scores_in_descending_order(@companies)

    if color_filters.present?
     @companies = filter_by_colors(@companies, color_filters)
    end
  end

  private

  def set_filter_period
    @filter_period = get_filtered_period(filter_params)
  end

  def filter_params
    return { period: '' } if params[:filter].nil?
    params.require(:filter).permit(:category, :date, :period, colors: [])
  end

  def color_filters
    params[:filter][:colors]
  end

  def filter_by_colors(companies, colors)
    companies.select{ |company| colors.include?(company.color) }
  end
end
