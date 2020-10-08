import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _name = '';
  String _email = '';
  String _address = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DocumentSnapshot>(context);
    final uid = Provider.of<User>(context);
    if (user != null && user.exists) {
      _name = user.data['name'];
      _email = user.data['email'];
      _address = user.data['address'];
      _phone = user.data['phone'];
    }
    return uid.isAnon
        ? Scaffold(
            resizeToAvoidBottomInset: true,
            body: new Container(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2 - 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Please, Login First",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 22.0,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        await _auth.signOut();
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Do you want to? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
              backgroundColor: Color(0xFF527DAA),
            ),
            body: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          '  معلومات الحساب',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InfoItem(
                        text: "البريد الالكتروني",
                        txt: _email,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InfoItem(
                        text: "الاسم",
                        txt: _name,
                        function: () {
                          showEditScreen(context, 'name', _email, _name,
                              _address, _phone, uid.uid);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InfoItem(
                        text: "رقم الهاتف",
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
                        text: "العنوان",
                        txt: _address,
                        function: () {
                          showEditScreen(context, 'address', _email, _name,
                              _address, _phone, uid.uid);
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
