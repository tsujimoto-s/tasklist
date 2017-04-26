class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit, :update] 
  

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'taskを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'taskの投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def edit
    @micropost = current_user.microposts.find(params[:id])
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'taskを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def update
    @micropost = current_user.microposts.find(params[:id])

    if @micropost.update(micropost_params)
      flash[:success] = 'taskは正常に更新されました'
      redirect_to root_path
    else
      flash.now[:danger] = 'taskは更新されませんでした'
      render :edit
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :status)
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_path
    end
    
  end
end