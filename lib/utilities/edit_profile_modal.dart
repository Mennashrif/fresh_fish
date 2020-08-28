import 'package:flutter/material.dart';
import 'package:fresh_fish/services/database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfModal extends StatefulWidget {
  final String change;
  final String uid;
  final String name;
  final String phone;
  final String address;
  final String email;
  EditProfModal(
      {this.change, this.uid, this.name, this.phone, this.address, this.email});

  @override
  _EditProfModalState createState() => _EditProfModalState();
}

class _EditProfModalState extends State<EditProfModal> {
  bool loading = false;
  String changedField = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'ادخل التحديث',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Color(0xFF527DAA),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              cursorColor: Color(0xFF527DAA),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF527DAA),
                ),
              )),
              onChanged: (newText) {
                changedField = newText;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            loading
                ? LinearProgressIndicator(
                    backgroundColor: Colors.blue[200],
                  )
                : FlatButton(
                    child: Text(
                      'حفظ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Color(0xFF527DAA),
                    onPressed: () async {
                      if (changedField.isNotEmpty) {
                        setState(() => loading = true);
                        DatabaseService databaseService =
                            DatabaseService(uid: widget.uid);
                        if(widget.change=='pN'&&widget.change.isNotEmpty&&widget.change[0]=='0'&&widget.change.length==11)
                          await databaseService.setUserData(
                            widget.email,
                            widget.change == 'name'
                                ? changedField
                                : widget.name,
                            widget.change == 'address'
                                ? changedField
                                : widget.address,
                            widget.change == 'pN'
                                ? changedField
                                : widget.phone);
                        else  Fluttertoast.showToast(
                            msg: "ادخل رقم الهاتف الصحيح",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      Navigator.pop(context);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
