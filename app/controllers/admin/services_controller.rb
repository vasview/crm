module Admin
	class ServicesController < BaseController
		def index
      @services = Service.order(:name)
    end

    def new
      @service = Service.new
    end

    def create
      @service = Service.new(service_params)

      if @service.save
        redirect_to admin_services_path, notice: "Новая услуга успешно добавлена."
      else
        render :new
      end
    end

    def edit
      @service = Service.find(params[:id])
    end

    def update
      @service = Service.find(params[:id])

      if @service.update_attributes(service_params)
        flash[:notice] = "Карточка типа услуги успешно отредактирована"

        redirect_to admin_services_path, notice: "Карточка типа услуги омики успешно обновлена."
      else
        render :edit
      end
    end

    def destroy
      @service = Service.find(params[:id])

      if @service.update_attribute('status', 'archived')
        redirect_to admin_services_path
      else
        render :edit
      end
    end

    private

    def service_params
      params.require(:service).permit(:id, :name, :description, :cost, :committee_cost, :status)
    end
	end
end