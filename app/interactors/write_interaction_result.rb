class WriteInteractionResult
  include Interactor

  def call
    if write = write_interaction_result()
      context.write = write
    else
      context.fail!(message: "write.error")
    end
  end

  private

  def params
    context.params
  end

  def interaction_id
    context.interaction.id
  end

  def write_interaction_result
    case define_company

    when 'all'
      companies = Company.status('active')
      service_cost = Service.find(params[:service_id].to_i).cost
      companies.map{ |company| save_result(company.id, service_cost) }

    when 'committee'
      committee = Committee.find(params[:committee_id])
      service_cost = Service.find(params[:service_id].to_i).committee_cost

      representatives = committee.representatives
      representatives.map{ |rep| save_result(rep.company_id, service_cost) }

    when 'company'
      company = Company.find(params[:company_id])
      service_cost = Service.find(params[:service_id].to_i).cost
      save_result(company.id, service_cost)
    else
      'Error: Отсутствуют данные для записи результатов взаимодействия'
    end
  end

  def define_company
    return 'all' unless context.all_members == '0'

    return 'committee' unless params[:committee_id].empty?

    return 'company' unless params[:company_id].empty?
  end

  def save_result(company, cost)
    interaction_result = InteractionResult.new(company_id: company,
                                               interaction_id: interaction_id,
                                               mark: cost)
    interaction_result.save
  end
end
