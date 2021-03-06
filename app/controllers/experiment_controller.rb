class ExperimentController < ApplicationController
  def index
    @user = current_user
    
    @pickupitems = Item.includes(:images).where(sold: 0).last(3)
    @item1 = @pickupitems[0]
    @item2 = @pickupitems[1] 
    @item3 = @pickupitems[2]

    #  不要と判断削除予定#リンクボックスの初期値設定
    #  @category_parent_array = ["---"]
    @category_parent_array = []

     #データベースから、親カテゴリーのみ抽出し、配列化
     Category.where(ancestry: nil).each do |parent|
       @category_parent_array << parent.name
     end
     
    # 親カテゴリーが選択された後に動くアクション
    def get_category_children
      #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
      @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
    end

    # 子カテゴリーが選択された後に動くアクション
    def get_category_grandchildren
      #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
      @category_grandchildren = Category.find("#{params[:child_id]}").children
    end

  end

  def sample
    @user = current_user
    @item = Item.new
  end

  def upexpectederrors
    # 予期せぬ動作が起きた場合に飛ぶページ用
    # エラーハンドリングの遷移先として置いてる
  end

end
