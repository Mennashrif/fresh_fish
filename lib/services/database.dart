import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_fish/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('Users');

   Future updateUserData(String email,String name,String address,String phone) async {
    return await brewCollection.document(uid).setData({
      'email':email,
      'name':name,
      'address':address,
      'phone':phone
    });
  }

}