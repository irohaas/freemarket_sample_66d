class PurchasesController < ApplicationController

  require "payjp"
  before_action :set_card, :set_item
  before_action :authenticate_user!

  # 購入確認画面
  def index
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_card_path
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id) 
      #カード情報表示のためインスタンス変数に代入
      @card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  # 購入
  def pay
    Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
    Payjp::Charge.create(
      :amount => @item.price, #支払金額を引っ張ってくる
      :customer => @card.customer_id,  #顧客ID
      :currency => 'jpy',              #円
    )
    redirect_to done_item_purchases_path #完了画面に移動
  end

  # 支払い完了ページ
  def done
  end

  private
  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
