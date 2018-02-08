module Admin
  class JobPositionsController < BaseController
    def index
      @job_position_all = JobPosition.all.order(:title)
    end

    def new
      @job_position = JobPosition.new
    end

    def create
      @job_position = JobPosition.new(job_position_params)

      if @job_position.save
        redirect_to admin_job_positions_path, notice: "Должность успешно добавлена."
      else
        render :new
      end
    end

    def edit
      @job_position = JobPosition.find(params[:id])
    end

    def update
      @job_position = JobPosition.find(params[:id])

      if @job_position.update_attributes(job_position_params)
        flash[:notice] = "Карточка должность успешно отредактирована"

        redirect_to admin_job_positions_path, notice: "Карточка должности успешно обновлена."
      else
        render :edit
      end
    end

    def destroy
      @job_position = JobPosition.find(params[:id])

      if @job_position.update_attribute('status', 'archived')
        redirect_to admin_job_positions_path
      else
        render :edit
      end
    end

    private

    def job_position_params
      params.require(:job_position).permit(:id, :title, :status)
    end
  end
end
