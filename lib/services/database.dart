import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_fish/models/item.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference Users = Firestore.instance.collection('Users');
  final CollectionReference Items=Firestore.instance.collection('Items');

   Future updateUserData(String email,String name,String address,String phone) async {
    return await Users.document(uid).setData({
      'email':email,
      'name':name,
      'address':address,
      'phone':phone
    });
  }
  Stream<QuerySnapshot> get users {
    return Users.where('uid',isEqualTo: uid).snapshots();
  }
  List<item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return item(
          name: doc.data['name'] ?? '0',
          price: doc.data['price'] ?? 0,
          category: doc.data['category'] ?? '0',
          Isoffered: doc.data['Isoffered'] ?? false,
          Waytoget: doc.data['Waytoget'] ?? '0'
      );
    }).toList();
  }

  // get brews stream
  Stream<List<item>> get items {
    return Items.snapshots()
        .map(_itemListFromSnapshot);
  }

}