class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true

  validates :price, numericality: {greater_than_or_equal_to: 0.01}

  #$B%F!<%V%k>e$N=EJ#%A%'%C%/(B
  validates :title, uniqueness: true

  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)$}i,
    message: '$B$O(BGIF JPG PNG$B2hA|$N(BURL$B$G$O$J$1$l$P$J$j$^$;$s!#(B'
  }

  private

  #$B$3$N>&IJ$r;2>H$7$F$$$kIJL\$,$J$$$3$H$r3NG'$9$k(B
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, '$BIJL\$,B8:_$7$^$9(B')
      return false
    end
  end
end
