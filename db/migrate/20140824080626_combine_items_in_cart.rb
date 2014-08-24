class CombineItemsInCart < ActiveRecord::Migration
  def up
    #$B%+!<%HFb$K=EJ#>&IJ$,B8:_$7$?>l9g$K#1$D$KCV$-49$($k(B
    Cart.all.each do |cart| #$B%+!<%H$N7+$jJV$7=hM}3+;O(B
      sums = cart.line_items.group(:product_id).sum(:quantity) #$BIJL\$N9g7W?tCM$r(Bproduct_id$B$G%0%k!<%W2=$7$F5a$a$k(B
      sums.each do |product_id, quantity| #$B9g7W?t$N%j%9%H7+$jJV$7=hM}3+;O(B
        if quantity > 1
          #$B8DJL$NIJL\$r:o=|(B
          cart.line_items.where(product_id: product_id).delete_all
          #1$B$D$NIJL\$KCV$-49$($k(B
          cart.line_items.create(product_id: product_id, quantity: quantity)
        end
      end

    end
  end

  def down
  end
end
