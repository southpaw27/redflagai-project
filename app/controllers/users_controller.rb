class UsersController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def edit
    render "edit", locals: { user: @user }
  end

  def update_user
    outcome = Interactions::Users::Update.run(user: @user, **project_params)
    if outcome.valid?
      redirect_to "/"
    else
      redirect_to edit_user_path(@user)
    end
  end

  def create_new
    outcome = Interactions::Users::Create.run(project_params)
    if outcome.valid?
      redirect_to "/"
    else
      render "new"
    end
  end

  def delete
  end

  private

  def project_params
    params.require(:user).permit(:name, :email, :password, :organization_id, :role_type, :nickname, :title, :work_focus)
  end
end
