module RepresentativesHelper
  def representative_fullname(params)
    [ params[:representative][:firstname],
      params[:representative][:middlename],
      params[:representative][:lastname] ].join(' ')
  end
end
