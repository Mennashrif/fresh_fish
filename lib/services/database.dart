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
  Future setUserData(
      String email, String name, String address, String phone) async {
    return await Users.document(uid).setData(
        {'email': email, 'name': name, 'address': address, 'phone': phone});
  }

  Future<bool> addOrder(List<orderitem> order) async {
    try {
      await Order.document().setData({
        'uid': uid,
        'timeStamp': DateTime.now().toIso8601String(),
        'delivered': false,
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

  Stream<DocumentSnapshot> get user {
    return Users.document(uid).snapshots();
  }

  Stream<QuerySnapshot> get users {
    return Users.snapshots();
  }

  List<item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return item(
          id: doc.documentID,
          name: doc.data['name'] ?? '0',
          price: doc.data['price'] ?? 0,
          category: doc.data['category'] ?? '0',
          Isoffered: doc.data['Isoffered'] ?? false,
          theOffer: doc.data['theOffer'] ?? 0,
          allquantity: doc.data['quantity'] ?? 0);
    }).toList();
  }

  Future<List<item>> fetchSearchResult(String searchString) async {
    List<item> result = [];
    QuerySnapshot querySnapshot = await Items.getDocuments();
    List<DocumentSnapshot> docSnapshot = querySnapshot.documents;
    docSnapshot.map((e) {
      if (e.data['name'].contains(searchString))
        result.add(item(
          name: e.data['name'],
          price: e.data['price'],
          category: e.data['category'],
          Isoffered: e.data['Isoffered'],
          sort: e.data['sort'],
          theOffer: e.data['theOffer'],

        ));
          }).toList();
    return result;
  }

  Future<int> makeOffer(int offer, String itemId) async {
    if (offer > 0) {
      await Items.document(itemId)
          .updateData({'theOffer': offer, 'Isoffered': true});
      return offer;
    }
    await removeOffer(itemId);
    return 0;
  }

  Future<void> removeOffer(String itemId) {
    return Items.document(itemId)
        .updateData({'theOffer': 0, 'Isoffered': false});
  }

  Future<void> changePrice(int newPrice, String itemId) {
    return Items.document(itemId).updateData({'price': newPrice});
  }

  Future<void> changeQuantity(int newQuantity, String itemId) {
    return Items.document(itemId).updateData({'quantity': newQuantity});
  }

  // get brews stream
  Stream<List<item>> get items {
    return Items.orderBy('sort').snapshots().map(_itemListFromSnapshot);
  }
}
