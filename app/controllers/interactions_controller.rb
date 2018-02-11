class InteractionsController < ApplicationController
  include FilterDates

  before_action :set_filter_period, only: [:index, :filter, :one_company_interactions]

  def index
    @interactions = Interaction.filter(period: @filter_period)
                               .order('created_at DESC')

    @interactions_count = @interactions.count
    @interactions = @interactions.paginate(page: params[:page])
  end

  def new
    @interaction = Interaction.new
  end

  def show
    @interaction = Interaction.find(params[:id])
  end

  def create
    @interaction = Interaction.create(interaction_params)
    if @interaction.save

      result = WriteInteractionResult.call(params: interaction_params,
                                           all_members: params[:interaction][:all_members][:selected],
                                           interaction: @interaction)

      redirect_to interaction_path(@interaction, { back_to_all: true })
    else
      render :edit
    end
  end

  def edit
    @interaction = Interaction.find(params[:id])
  end

  def update
    @interaction = Interaction.find(params[:id])

    if @interaction.update_attributes(interaction_params)

      @interaction.interaction_results.each { |result| result.destroy }

      result = WriteInteractionResult.call(params: interaction_params,
                                           all_members: params[:interaction][:all_members][:selected],
                                           interaction: @interaction)

      redirect_to interaction_path(@interaction, { back_to_all: true })
    else
      render :edit
    end
  end

  def one_company_interactions
    @company = Company.find(params[:company_id])

    @interactions = Interaction.includes(:interaction_results)
                               .where(interaction_results: {company_id: @company.id})
                               .filter(period: @filter_period)
                               .order('start_date DESC')

    @interactions_count = @interactions.count
    @interactions = @interactions.paginate(page: params[:page])

    respond_to do |format|
      format.html { render 'index' }
    end
  end

  def filter
    if params[:company_id].present?
      @interactions = Interaction.includes(:interaction_results)
                               .where(interaction_results: {company_id: filter_params.fetch(:company)})
                               .filter(period: @filter_period)
                               .filter(filter_params.slice(:service, :user))
                               .order('start_date DESC')
    else
      @interactions = Interaction.filter(period: @filter_period)
                                 .filter(filter_params.slice(:company, :service, :user))
                                 .order('created_at DESC')
    end

      @interactions_count = @interactions.count
      @interactions = @interactions.paginate(page: params[:page])

    respond_to do |format|
      format.js
    end
  end

  private

  def interaction_params
    params.require(:interaction).permit(:id, :start_date, :end_date,
                                        :company_id, :representative_id,
                                        :service_id, :user_id, :notes,
                                        :committee_id, :category_id)
  end

  def filter_params
    return {period: ''} if params[:filter].nil?
    params.require(:filter).permit(:company, :service, :date, :period, :user)
  end

  def set_filter_period
    if params[:action] == 'one_company_interactions'
      @filter_period = [DateTime.parse(session[:filter_period].first), DateTime.parse(session[:filter_period].last)]
    else
      @filter_period = get_filtered_period(filter_params)
    end
  end
end
