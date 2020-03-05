class CartItem {
  String name;
  double price;
  int quantity;

  CartItem(String name, double price, int quantity) {
    this.name = name;
    this.price = price;
    this.quantity = quantity;
  }

  double totalPrice() {
    return price * quantity;
  }

  @override
  String toString() {
    return 'Cart item: $name $price $quantity';
  }
}
