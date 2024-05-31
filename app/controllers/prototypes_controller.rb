class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: :destroy
  def index
    @prototypes = Prototype.all
  end

  def new
    authenticate_user!
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
      redirect_to root_path
    end
    @prototype = Prototype.find(params[:id])
  end

  def update
  if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
    @comment = Comment.new
  end
  
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end
end

