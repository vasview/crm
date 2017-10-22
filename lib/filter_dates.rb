module FilterDates

  def get_filtered_period(params)
    filtered_period = []

    case date_filter(params)
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
        period = period_filter(params).split(' - ')
        start_day = Date.parse(period.first)
        end_day = Date.parse(period.last)
      else
        start_day = default_start_day
        end_day = default_end_day
    end

    filtered_period = [start_day, end_day]
  end

  def period_filter(params)
    params[:period]
  end

  def date_filter(params)
    params[:date]
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

end
