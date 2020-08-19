import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_fish/models/item.dart';
import 'package:fresh_fish/models/orderitem.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference Users = Firestore.instance.collection('Users');
  final CollectionReference Items = Firestore.instance.collection('Items');
  final CollectionReference Order = Firestore.instance.collection('Order');
  Future updateUserData(
      String email, String name, String address, String phone) async {
    return await Users.document(uid).updateData(
        {'email': email, 'name': name, 'address': address, 'phone': phone});
  }

  Future<bool> addOrder(List<orderitem> order) async {
    try {
      await Order.document().setData({
        'uid': uid,
        'content': [
          for (int i = 0; i < order.length; i++)
            {
              "name": order[i].name,
              "quantity": order[i].quantity,
              "optionName": order[i].optionName,
              "price": order[i].price,
              "optionPrice": order[i].optionPrice,
              "Isoffered": order[i].Isoffered,
            },
        ]
      });
      return true; 
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> get users {
    return Users.where('uid', isEqualTo: uid).snapshots();
  }

  List<item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return item(
          name: doc.data['name'] ?? '0',
          price: doc.data['price'] ?? 0,
          category: doc.data['category'] ?? '0',
          Isoffered: doc.data['Isoffered'] ?? false,
          theOffer:doc.data['theOffer']??0);

    }).toList();
  }

  // get brews stream
  Stream<List<item>> get items {
    return Items.orderBy('sort').snapshots().map(_itemListFromSnapshot);
  }
}
