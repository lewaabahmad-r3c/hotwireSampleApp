module CartItemsHelper
  def funny_cart_message(item_count)
    case item_count
    when 1
      "First item added! Let's start filling up that cart!"
    when 2..4
      "Nice! You’ve got #{item_count} items in your cart now!"
    when 5..9
      "Whoa, #{item_count} items? Someone’s on a shopping spree!"
    when 10..14
      "Double digits! #{item_count} items in the cart. You’re on fire!"
    when 15..19
      "Wow, #{item_count} items! Maybe take a break? Nah, keep going!"
    else
      "#{item_count} items?! Are you buying out the entire store?"
    end
  end
end
