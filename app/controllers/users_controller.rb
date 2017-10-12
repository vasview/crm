class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def create
    @user = User.create(user_params.merge(fullname: user_fullname))

    if @user.save
      redirect_to users_path, notice: "Пользователь успешно добавлен."
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params.merge(fullname: user_fullname))
      flash[:notice] = "Карточка пользователя успешно отредактирована"

      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to users_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :firstname, :middlename,
                                 :lastname, :work_phone, :mobile_phone,
                                 :email, :job_position_id, :role_id)
  end

  def user_fullname
    [params[:user][:firstname], params[:user][:middlename], params[:user][:lastname]].join(' ')
  end
end
