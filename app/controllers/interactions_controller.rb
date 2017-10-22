class InteractionsController < ApplicationController
  include FilterDates

  def index
    @interactions = Interaction.paginate(page: params[:page])
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

      write_interaction_result

      redirect_to interaction_path(@interaction)
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

      @interaction.interaction_results.each {|result| result.destroy}

      write_interaction_result

      redirect_to interaction_path(@interaction)
    else
      render :edit
    end
  end

  def one_company_interactions
    @company = Company.find(params[:company_id])
    @interactions = Interaction.company(@company.id)
                                .paginate(page: params[:page])
  end

  def get_filtered_interactions
    filter_period = get_filtered_period(filter_params)
    binding.pry
  end

  private

  def interaction_params
    params.require(:interaction).permit(:id, :start_date, :end_date,
                                       :company_id, :representative_id,
                                       :service_id, :user_id, :notes,
                                       :committee_id, :category_id)
  end

  def filter_params
    params.require(:filter).permit(:company, :service, :date, :period, :user)
  end

  def write_interaction_result
    case define_company

    when 'all'
      companies = Company.all
      service_cost = Service.find(params[:interaction][:service_id].to_i).cost
      companies.map{|company| save_result(company.id, service_cost)}

    when 'committee'
      committee = Committee.find(params[:interaction][:committee_id])
      service_cost = Service.find(params[:interaction][:service_id].to_i).committee_cost

      representatives = committee.representatives
      representatives.map{|rep| save_result(rep.company_id, service_cost)}

    when 'company'
      company = Company.find(params[:interaction][:company_id])
      service_cost = Service.find(params[:interaction][:service_id].to_i).cost
      save_result(company.id, service_cost)
    else
      'Error: Отсутствуют данные для записи результатов взаимодействия'
    end
  end

  def define_company
    return 'all' unless params[:all_members][:selected] == '0'

    return 'committee' unless params[:interaction][:committee_id].empty?

    return 'company' unless params[:interaction][:company_id].empty?
  end

  def save_result(company, cost)
    interaction_result = InteractionResult.new(company_id: company,
                                               interaction_id: @interaction.id,
                                               mark: cost)
    interaction_result.save
  end
end
