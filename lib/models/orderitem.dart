class orderitem {
  final id;
  final num quantity;
  final String name;
  final num price;
  final String category;
  final String optionName;
  final num optionPrice;
  final bool Isoffered;
  final num theOffer;
  final num allquantity;
  orderitem(
      this.id,
      this.name,
      this.price,
      this.category,
      this.quantity,
      this.Isoffered,
      this.optionName,
      this.optionPrice,
      this.theOffer,
      this.allquantity);
}
