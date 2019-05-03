class PostsController < ApplicationController
  def index
    @posts = Post.all
    @new_posts = Post.all
    @author = Author.first
  end

  def show
    @post = Post.find(params[:id])

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
    @post = Post.find(params[:id])
    puts "----------------------------------"
    p @post
  end

  def update
    # updateデータを取得([:id])を使用して
    #update メソッドを使って更新
    @post = Post.find(params[:id])
    # 詳細画面にリダイレクト
    @post.update(post_params)
    redirect_to @post
  end

  def destroy
    # 対象データを1件取得する
    @post = Post.find(params[:id])
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

end
