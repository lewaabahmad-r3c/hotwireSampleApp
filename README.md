# FISH STORE

1. Generate the Models
Run the following commands to generate the models:

```
rails generate model Product name:string price:decimal
rails generate model Cart session_id:string
rails generate model CartItem cart:references product:references quantity:integer
```

These commands will create the necessary migrations and models for Product, Cart, and CartItem. After generating the models, run the migrations to update your database schema: `rails db:migrate`

3. Set Up Models and Relationships
Now, we'll define the models and their relationships:

app/models/product.rb:
```
class Product < ApplicationRecord
  has_many :cart_items
  has_many :carts, through: :cart_items

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
```

app/models/cart.rb:
```
class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total_price
    cart_items.to_a.sum { |item| item.total_price }
  end
end
```

app/models/cart_item.rb:
```
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def total_price
    unit_price * quantity
  end
end
```

4. Define Routes

```
Rails.application.routes.draw do
  # Routes for products
  resources :products, only: [:index, :show]

  # Route for the cart
  resource :cart, only: [:show]

  # Routes for cart items
  resources :cart_items, only: [:create, :update, :destroy]

  # Root path
  root "products#index"
end
```

5. Generate the Controllers and define their actions:
Next, generate the controllers:

```
rails generate controller Products index show
rails generate controller Carts show
rails generate controller CartItems create update destroy
```

Now, let's add the basic actions to the controllers.

app/controllers/products_controller.rb:
```
class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
```

app/controllers/carts_controller.rb:
```
class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
```

app/controllers/cart_items_controller.rb:
```
class CartItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    @cart_item.quantity += 1
    @cart_item.unit_price = product.price
    @cart_item.save

    respond_to do |format|
      format.html { redirect_to cart_path(@cart) }
      format.turbo_stream
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_path(@cart_item.cart)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(@cart_item.cart)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
```