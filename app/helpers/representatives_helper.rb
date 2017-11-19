module RepresentativesHelper
  def representative_fullname(fio)
    fullname = [fio[:firstname], fio[:middlename], fio[:lastname]]
    fullname.join(' ')
  end
end
