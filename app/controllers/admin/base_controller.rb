module Admin
  class BaseController < ::ApplicationController
    before_action :require_admin

    include AdminHelper

    layout "admin"

    def require_admin
      unless current_user.role.title == "ADMIN"
        redirect_to root_path
      end
    end
  end
end
