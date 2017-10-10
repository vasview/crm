class RepresentativesController < ApplicationController

  def new
    @representative = Representative.new
    @representative.committee_representatives.build
  end

  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find(params[:id])
  end

  def create
    @representative = Representative.create(representative_params.merge(fullname: representative_fullname))

    @count_committees =1
    @representative.committee_representatives.each do |com_rep|
      com_rep.committee_id = representative_params[:committee_representatives_attributes]["0"][:committee_id][@count_committees]
      @count_committees += 1
    end

    if @representative.save

      representative_params[:committee_representatives_attributes]["0"][:committee_id].drop(@count_committees).each do |com_rep|
        @committee = @representative.committee_representatives.build(committee_id: representative_params[:committee_representatives_attributes]["0"][:committee_id][@count_committees])
        @committee.save
        @count_committees += 1
      end

      redirect_to representatives_path, notice: "Карточка представителя компании успешно добавлен."
    else
      render :new
    end
  end

  def edit
    @representative = Representative.find(params[:id])
    @representative.committee_representatives.build unless @representative.committee_representatives.present?
  end

  def update
    @representative = Representative.find(params[:id])

    @count_committees = representative_committees_params.size


      @representative.committee_representatives.clear

      (0...@count_committees).each do |count|
        @committee = @representative.committee_representatives.build(committee_id: representative_committees_params[count])
        @committee.save
      end
    if @representative.update_attributes(representative_update_params)

      redirect_to representative_path(@representative), notice: "Карточка представителя компании успешно отредактирована."
    else
      render :edit
    end
  end

  def destroy
    @representative = Representative.find(params[:id])

    @representative.destroy

    redirect_to representatives_path, notice: "Карточка представителя компании удалена."
  end

  def get_filtered_representatives

  end  

  private

  def representative_params
    params.require(:representative).permit(:id, :firstname, :middlename, :lastname,
                                           :work_phone, :mobile_phone, :email, :company_id,
                                           :job_position_id, :birthdate, :notes,
                                           committee_representatives_attributes: [committee_id: [] ])
  end

  def representative_fullname
    [ params[:representative][:firstname],
      params[:representative][:middlename],
      params[:representative][:lastname] ].join(' ')
  end

  def representative_committees_params
    representative_params[:committee_representatives_attributes]["0"][:committee_id].reject{|n| n.empty?}
  end

  def representative_update_params
    representative_params.merge(fullname: representative_fullname)
    representative_params.except(:committee_representatives_attributes)
  end
end
