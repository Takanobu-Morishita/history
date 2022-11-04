class DocumentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.user_id = current_user.id
    if @document.save
    redirect_to document_path(@document), notice: '投稿に成功しました。'
    else
      render :new
    end
  end

  def edit
    @document = Document.find(params[:id])
    if @document.user != current_user
      redirect_to documents_path, alert: '不正なアクセスです'
    end
  end

  def update
    @document = Document.find(params[:id])
    if @document.update(document_params)
      redirect_to document_path(@document), notice: '更新に成功しました。'
    else
      render :edit
    end
  end

  private
  def document_params
    params.require(:document).permit(:title, :body, :image)
  end
end
