import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_fish/models/user.dart';
import 'package:fresh_fish/utilities/edit_profile_modal.dart';
import 'package:fresh_fish/utilities/profile_info_item.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = '';
  String _email = '';
  String _address = '';
  String _phone = '';

  void getdata(final user, final uid) {
    if (user != null) {
      for (int i = 0; i < user.documents.length; i++) {
        if (user.documents[i].documentID == uid.uid) {
          _name = user.documents[i].data['name'];
          _email = user.documents[i].data['email'];
          _address = user.documents[i].data['address'];
          _phone = user.documents[i].data['phone'];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<QuerySnapshot>(context);
    final uid = Provider.of<User>(context);
    getdata(user, uid);
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color(0xFF527DAA),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView(children: <Widget>[
              Text(
                '  Account Information',
                style: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              InfoItem(
                text: "Email",
                txt: _email,
              ),
              SizedBox(
                height: 10,
              ),
              InfoItem(
                text: "Name",
                txt: _name,
                function: () {
                  showEditScreen(context, 'name', _email, _name, _address,
                      _phone, uid.uid);
                },
              ),
              SizedBox(
                height: 10,
              ),
              InfoItem(
                text: "Phone Number",
                txt: _phone,
                function: () {
                  showEditScreen(context, 'pN', _email, _name, _address,
                      _phone, uid.uid);
                },
              ),
              SizedBox(
                height: 10,
              ),
              InfoItem(
                text: "Address",
                txt: _address,
                function: () {
                  showEditScreen(context, 'address', _email, _name, _address,
                      _phone, uid.uid);
                },
              ),
              SizedBox(
                height: 10,
              )
            ])));
  }

  showEditScreen(var context, String change, String email, String name, address,
      String phone, String uid) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: EditProfModal(
                change: change,
                email: email,
                name: name,
                address: address,
                phone: phone,
                uid: uid,
              ),
            )));
  }
}
