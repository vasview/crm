module MainHelper
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
    interaction_results.map{ |result| marks << result.mark }
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
end
