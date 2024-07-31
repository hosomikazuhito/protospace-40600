class PrototypesController < ApplicationController

  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  

  def new
    @prototype = Prototype.new 
  end

  def index
  @prototypes = Prototype.all
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments
    @comment = Comment.new
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
     @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  
  def create
    @prototype = current_user.prototypes.build(prototype_params)  # current_userを使って関連付ける
    if @prototype.save
      redirect_to @prototype, notice: 'Prototype was successfully created.'
    else
      logger.debug @prototype.errors.full_messages  # エラーメッセージをログに出力
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
   
    def prototype_params
      params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
    end
  end