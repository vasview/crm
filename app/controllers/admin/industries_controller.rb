module Admin
  class IndustriesController < BaseController
    def index
      @industry_all = Industry.all.order(:title)
    end

    def new
      @industry = Industry.new
    end

    def create
      @industry = Industry.new(industry_params)

      if @industry.save
        redirect_to admin_industries_path, notice: "Сектор экономики успешно добавлен."
      else
        render :new
      end
    end

    def edit
      @industry = Industry.find(params[:id])
    end

    def update
      @industry = Industry.find(params[:id])

      if @industry.update_attributes(industry_params)
        flash[:notice] = "Карточка сектора экономики успешно отредактирована"

        redirect_to admin_industries_path, notice: "Карточка сектора экономики успешно обновлена."
      else
        render :edit
      end
    end

    def destroy
      @industry = Industry.find(params[:id])

      if @industry.update_attribute('status', 'archived')
        redirect_to admin_industries_path
      else
        render :edit
      end
    end

    private

    def industry_params
      params.require(:industry).permit(:id, :title, :status)
    end
  end
end
