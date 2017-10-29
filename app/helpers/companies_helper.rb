module CompaniesHelper
  COMPANY_COLORS = %w( RED YELLOW GREEN )

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
