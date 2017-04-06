class AddTitleToCartItem < ActiveRecord::Migration[5.0]
  def change
    add_column :cart_items, :title, :string
  end
end
