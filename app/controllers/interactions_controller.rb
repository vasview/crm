class InteractionsController < ApplicationController
  def new
    @interaction = Interaction.new
  end

  def show
    @interaction = Interaction.find(params[:id])
  end

  def create
    @interaction = Interaction.create(interaction_params)
    if @interaction.save

      #TODO make an estimation of the interaction
      redirect_to interaction_path(@interaction)
    else
      render :edit
    end
  end

  def edit
    @interaction = Interaction.find(params[:id])
  end

  def update
    @interaction = Interaction.find(params[:id])

    if @interaction.update_attributes(interaction_params)
      #TODO make updates for estimate
      redirect_to interaction_path(@interaction)
    else
      render :edit
    end
  end

  private

  def interaction_params
    params.require(:interaction).permit(:id, :start_date, :end_date,
                                       :company_id, :representative_id,
                                       :service_id, :user_id, :notes,
                                       :committee_id, :category_id)
  end

end
