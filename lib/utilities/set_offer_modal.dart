import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fresh_fish/services/database.dart';

class EditProductModal extends StatefulWidget {
  final itemId;
  final String helperText;

  EditProductModal({this.itemId, @required this.helperText});

  @override
  _EditProductModalState createState() => _EditProductModalState();
}

class _EditProductModalState extends State<EditProductModal> {
  bool loading = false;
  String changedField;
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
              widget.helperText,
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
              keyboardType: TextInputType.number,
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
                        DatabaseService databaseService = DatabaseService();
                        if (widget.helperText == 'ادخل الخصم') {
                          await databaseService.makeOffer(
                              int.parse(changedField), widget.itemId);
                        } else if (widget.helperText == 'ادخل الكمية')
                          await databaseService.changeQuantity(
                              int.parse(changedField), widget.itemId);
                        else
                          await databaseService.changePrice(
                              int.parse(changedField), widget.itemId);

                        Fluttertoast.showToast(
                            msg: "تم التحديث بنجاح",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.green,
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
