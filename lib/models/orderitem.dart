import 'dart:convert';
class orderitem {
  final id;
  final image;
  final num quantity;
  final String name;
  final num price;
  final String category;
  final String optionName;
  final num optionPrice;
  final bool Isoffered;
  final num theOffer;
  final num allquantity;
  orderitem(this.id,
      this.image,
      this.name,
      this.price,
      this.category,
      this.quantity,
      this.Isoffered,
      this.optionName,
      this.optionPrice,
      this.theOffer,
      this.allquantity);

  factory orderitem.fromJson(Map<String, dynamic> jsonData) {
    return orderitem(
       jsonData['id'],
       jsonData['image'],
       jsonData['name'],
       jsonData['price'],
       jsonData['category'],
       jsonData['quantity'],
       jsonData['Isoffered'],
       jsonData['optionName'],
       jsonData['optionPrice'],
       jsonData['theOffer'],
       jsonData['allquantity'],
    );
  }

  static Map<String, dynamic> toMap(orderitem Orderitem) =>
      {
        'id': Orderitem.id,
        'image': Orderitem.image,
        'quantity': Orderitem.quantity,
        'name': Orderitem.name,
        'price': Orderitem.price,
        'category': Orderitem.category,
        'optionName': Orderitem.optionName,
        'optionPrice': Orderitem.optionPrice,
        'Isoffered': Orderitem.Isoffered,
        'theOffer': Orderitem.theOffer,
        'allquantity': Orderitem.allquantity,
      };

  static String encodeOrder(List<orderitem> orders) =>
      json.encode(
        orders
            .map<Map<String, dynamic>>((Orderitem) =>
            orderitem.toMap(Orderitem))
            .toList(),
      );

  static List<orderitem> decodeOrder(String Orderitems) =>
      (json.decode(Orderitems) as List<dynamic>)
          .map<orderitem>((item) => orderitem.fromJson(item))
          .toList();
}