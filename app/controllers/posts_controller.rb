class PostsController < ApplicationController

before_action :set_post, only: [:show, :edit, :destroy, :update]

  def index
    @q = Post.order(created_at: :desc).ransack(params[:q])
    @posts = @q.result.page(params[:page]).per(2)
    @new_posts = Post.find_newest_article
    @author = Author.first
  end

  def show
    set_post

  end

  def new
    @post = Post.new
  end

  def create
    # Postモデルのインスタンスを生成(ストロングパラメータを作成
    @post = Post.new(post_params)
    @post.save
    redirect_to @post
  end

  def edit
    set_post
    puts "----------------------------------"
    p @post
  end

  def update
    # updateデータを取得([:id])を使用して
    #update メソッドを使って更新
    set_post
    # 詳細画面にリダイレクト
    @post.update(post_params)
    redirect_to @post
  end

  def destroy
    # 対象データを1件取得する
    set_post
    # destroyアクションで消す
    @post.destroy
    # 一覧ページにリダイレクトする
#    redirect_to @post
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
