def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.size do
    if collection[i][:item] == name
      return collection[i]
    end
    i += 1
  end
  return nil  
end


def consolidate_cart(cart)
  new_cart = []
  cart_index = 0
  while cart_index < cart.size do
    item = cart[cart_index][:item]
    new_cart_item = find_item_by_name_in_collection(item, new_cart)
    if new_cart_item
      new_cart_item[:count] += 1
    else
      new_cart_item = {
        :item=> cart[cart_index][:item],
        :price=> cart[cart_index][:price],
        :clearance=> cart[cart_index][:clearance],
        :count=> 1
        }
      new_cart << new_cart_item
    end
    cart_index += 1 
  end
  return new_cart
end


def apply_coupons(cart, coupons)
  coupons_index = 0
  while coupons_index < coupons.length do
    item = coupons[coupons_index][:item]
    cart_item = find_item_by_name_in_collection(item, cart)
    
    couponed_item_name = "#{coupons[coupons_index][:item]} W/COUPON"
    couponed_item = find_item_by_name_in_collection(couponed_item_name, cart)

    if cart_item && cart_item[:count] >= coupons[coupons_index][:num]
      if couponed_item
        couponed_item[:count] += coupons[coupons_index][:num]
        cart_item[:count] -= coupons[coupons_index][:num]
      else
        couponed_item = {
          :item => couponed_item_name,
          :price => coupons[coupons_index][:cost]/coupons[coupons_index][:num], 
          :clearance => cart_item[:clearance],
          :count => coupons[coupons_index][:num]
          }
          
          cart << couponed_item
          cart_item[:count] -= coupons[coupons_index][:num]
      end
    end
    coupons_index += 1
  end
  return cart
end



def apply_clearance(cart)
  cart_index = 0
  while cart_index < cart.length do
    item = cart[cart_index]
    item_clearance = cart[cart_index][:clearance]
    if item_clearance
      item[:price] = item[:price] - (item[:price] * 0.20)
    end
    cart_index += 1
  end
  return cart
end



def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
