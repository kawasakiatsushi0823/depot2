class CombineItemsInCart < ActiveRecord::Migration
  def up
    #カート内に重複商品が存在した場合に１つに置き換える
    Cart.all.each do |cart| #カートの繰り返し処理開始
      sums = cart.line_items.group(:product_id).sum(:quantity) #品目の合計数値をproduct_idでグループ化して求める
      sums.each do |product_id, quantity| #合計数のリスト繰り返し処理開始
        if quantity > 1
          #個別の品目を削除
          cart.line_items.where(product_id: product_id).delete_all
          #1つの品目に置き換える
          cart.line_items.create(product_id: product_id, quantity: quantity)
        end
      end

    end
  end

  def down
  end
end
