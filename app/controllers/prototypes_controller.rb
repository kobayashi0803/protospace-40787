class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = current_user.prototypes.build(prototype_params)
    if @prototype.save
      redirect_to root_path, notice: 'Prototype was successfully created.'
    else
      flash.now[:alert] = 'There was an error creating the prototype.'
      render :new
    end
  end

  def edit
    unless user_signed_in?
      redirect_to action: index
    end
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to @prototype, notice: 'Prototype was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @comments = @prototype.comments.includes(:user)
    @comment = Comment.new
  end
  
  def destroy
    @prototype.destroy
    redirect_to root_path, notice: 'Prototype was successfully deleted.'
  end

  private

  def set_prototype
    @prototype = Prototype.find_by(id: params[:id])
  end

  def authorize_user!
    unless @prototype.user == current_user
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to root_path
    end
  end
  
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end
end
