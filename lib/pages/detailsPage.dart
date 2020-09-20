import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fresh_fish/models/orderitem.dart';
import 'package:fresh_fish/services/database.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';
import 'package:fresh_fish/utilities/set_offer_modal.dart';
import 'package:extended_image/extended_image.dart';

class DetailsPage extends StatefulWidget {
  final heroTag;
  final order;
  final edit;
  final index;
  final refresh;
  final Item;
  final isAdmin;
  DetailsPage({
    this.heroTag,
    this.order,
    this.edit = false,
    this.index = 0,
    this.refresh,
    this.Item,
    this.isAdmin,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var selectedCard = 'WEIGHT';
  var quantity = 0.0;
  var optionPrice = 0.0;
  var optionName = '';
  var _character = 'نى';
  DatabaseService databaseService = DatabaseService();

  Widget option() {
    if (widget.Item.category.contains('جمبرى')) {
      return Container(
          height: 120.0,
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            _character == 'نى'
                ? _buildInfoCard('بدون', '0', 'L.e')
                : new Container(),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله قلي' : 'مقلى',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله مشوى' : 'مشوى',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله صنية' : 'صنية',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله butterfly' : 'butterfly',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
          ]));
    } else if (widget.Item.category.contains('كابوريا'))
      return Container(
          height: 120.0,
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            _character == 'نى'
                ? _buildInfoCard('بدون', '0', 'L.e')
                : new Container(),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله مشوى' : 'مشوى',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله صنية' : 'صنية',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
          ]));
    else if (widget.Item.category.contains('جاندوفلى و بلح بحر'))
      return Container(
          height: 120.0,
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            _character == 'نى'
                ? _buildInfoCard('بدون', '0', 'L.e')
                : new Container(),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله سلق' : 'سلق',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله طاجن' : 'طاجن',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
          ]));
    else if (widget.Item.category.contains('فيليه'))
      return Container(
          height: 120.0,
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            _character == 'نى'
                ? _buildInfoCard('بدون', '0', 'L.e')
                : new Container(),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله قلي' : 'مقلى',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله مشوى' : 'مشوى',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله طاجن' : 'طاجن',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله صنية' : 'صنية',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
          ]));
    else if (widget.Item.category.contains('الاسماك')) {
      if (widget.Item.name.contains('المكرونة') ||
          widget.Item.name.contains('الموسى'))
        return Container(
            height: 120.0,
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              _character == 'نى'
                  ? _buildInfoCard('بدون', '0', 'L.e')
                  : new Container(),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  _character == 'نى' ? 'تتبيله قلي' : 'مقلى',
                  _character == 'نى' ? 'مجاني' : '5',
                  _character == 'نى' ? '' : 'L.e'),
            ]));
      else if (widget.Item.name.contains('دراك') ||
          widget.Item.name.contains('تونة') ||
          widget.Item.name.contains('ثعابين'))
        return Container(
            height: 120.0,
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              _character == 'نى'
                  ? _buildInfoCard('بدون', '0', 'L.e')
                  : new Container(),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  _character == 'نى' ? 'تتبيله قلي' : 'مقلى',
                  _character == 'نى' ? 'مجاني' : '5',
                  _character == 'نى' ? '' : 'L.e'),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  _character == 'نى' ? 'تتبيله مشوى' : 'مشوى',
                  _character == 'نى' ? 'مجاني' : '5',
                  _character == 'نى' ? '' : 'L.e'),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  _character == 'نى' ? 'تتبيله صنية' : 'صنية',
                  _character == 'نى' ? 'مجاني' : '5',
                  _character == 'نى' ? '' : 'L.e'),
            ]));
      else if (widget.Item.name.contains('سردين') ||
          widget.Item.name.contains('سهلية'))
        return Container(
            height: 120.0,
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              _character == 'نى'
                  ? _buildInfoCard('بدون', '0', 'L.e')
                  : new Container(),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  _character == 'نى' ? 'تتبيله مشوى' : 'مشوى',
                  _character == 'نى' ? 'مجاني' : '5',
                  _character == 'نى' ? '' : 'L.e'),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  _character == 'نى' ? 'تتبيله صنية' : 'صنية',
                  _character == 'نى' ? 'مجاني' : '5',
                  _character == 'نى' ? '' : 'L.e'),
            ]));
      else if (widget.Item.name.contains('بربون') ||
          widget.Item.name.contains('المرجان'))
        return Container(
            height: 120.0,
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              _character == 'نى'
                  ? _buildInfoCard('بدون', '0', 'L.e')
                  : new Container(),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  _character == 'نى' ? 'تتبيله قلي' : 'مقلى',
                  _character == 'نى' ? 'مجاني' : '5',
                  _character == 'نى' ? '' : 'L.e'),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  _character == 'نى' ? 'تتبيله صنية' : 'صنية',
                  _character == 'نى' ? 'مجاني' : '5',
                  _character == 'نى' ? '' : 'L.e'),
            ]));
      else
        return Container(
            height: 120.0,
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              _character == 'نى'
                  ? _buildInfoCard('بدون', '0', 'L.e')
                  : new Container(),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  _character == 'نى' ? 'تتبيله قلي' : 'مقلى',
                  _character == 'نى' ? 'مجاني' : '5',
                  _character == 'نى' ? '' : 'L.e'),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  _character == 'نى' ? 'تتبيله سنجارى' : 'سنجارى',
                  _character == 'نى' ? 'مجاني' : '5',
                  _character == 'نى' ? '' : 'L.e'),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  _character == 'نى' ? 'تتبيله صنية' : 'صنية',
                  _character == 'نى' ? 'مجاني' : '5',
                  _character == 'نى' ? '' : 'L.e'),
            ]));
    } else if (widget.Item.category.contains('استاكوزا'))
      return Container(
          height: 120.0,
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            _character == 'نى'
                ? _buildInfoCard('بدون', '0', 'L.e')
                : new Container(),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله فرن' : 'فرن',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
          ]));
    else if (widget.Item.category.contains('سلمون')) {
      if (widget.Item.name.contains('سلمون مدخن')) {
        return Container(
          child: Text("This is a spcial plate",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold)),
        );
      } else {
        if (_character == 'نى')
          return Container(
              height: 120.0,
              child:
                  ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                _character == 'نى'
                    ? _buildInfoCard('بدون', '0', 'L.e')
                    : new Container(),
                SizedBox(width: 10.0),
                _buildInfoCard(
                    'تتبيله زيت زيتون',
                    _character == 'نى' ? 'مجاني' : '5',
                    _character == 'نى' ? '' : 'L.e'),
                SizedBox(width: 10.0),
                _buildInfoCard(
                    'تتبيله كرافس',
                    _character == 'نى' ? 'مجاني' : '5',
                    _character == 'نى' ? '' : 'L.e')
              ]));
        else
          return Container(
              height: 120.0,
              child:
                  ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                _character == 'نى'
                    ? _buildInfoCard('بدون', '0', 'L.e')
                    : new Container(),
                SizedBox(width: 10.0),
                _buildInfoCard('مقلى', _character == 'نى' ? 'مجاني' : '5',
                    _character == 'نى' ? '' : 'L.e'),
                SizedBox(width: 10.0),
                _buildInfoCard('طاجن', _character == 'نى' ? 'مجاني' : '5',
                    _character == 'نى' ? '' : 'L.e'),
                SizedBox(width: 10.0),
                _buildInfoCard('مشوى', _character == 'نى' ? 'مجاني' : '5',
                    _character == 'نى' ? '' : 'L.e')
              ]));
      }
    } else
      return Container(
          height: 120.0,
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            _character == 'نى'
                ? _buildInfoCard('بدون', '0', 'L.e')
                : new Container(),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله قلي' : 'مقلى',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله مشوى' : 'مشوى',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
            SizedBox(width: 10.0),
            _buildInfoCard(
                _character == 'نى' ? 'تتبيله صنية' : 'صنية',
                _character == 'نى' ? 'مجاني' : '5',
                _character == 'نى' ? '' : 'L.e'),
          ]));
  }

  @override
  void initState() {
    super.initState();
    quantity = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.refresh();
        return true;
      },
      child: Scaffold(
          backgroundColor: Color(0xFF7A9BEE),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                // just refresh() if its statelesswidget
                widget.refresh();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text('التفاصيل',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18.0,
                    color: Colors.white)),
            centerTitle: true,
            actions: <Widget>[
              widget.edit
                  ? new Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Visibility(
                          visible: widget.isAdmin,
                          child: GestureDetector(
                              onTap: () async {
                                showEditScreen(
                                    context, widget.Item.id, 'ادخل الخصم');
                              },
                              child: Icon(Icons.local_offer)),
                        ),
                        widget.edit
                            ? new Container()
                            : widget.order
                                ? fixedicon(
                                    order: widget.order,
                                    refresh: widget.refresh,
                                  )
                                : fixedicon(
                                    order: widget.order,
                                    refresh: refresh,
                                  ),
                      ],
                    ),
            ],
          ),
          body: ListView(children: [
            Stack(children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.96,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45.0),
                            topRight: Radius.circular(45.0),
                          ),
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height * 0.86,
                      width: MediaQuery.of(context).size.width)),
              Positioned(
                  top: 30.0,
                  left: (MediaQuery.of(context).size.width * 0.27),
                  child: Hero(
                      tag: widget.heroTag,
                      child:ExtendedImage.network(
                        widget.heroTag,
                        width: MediaQuery.of(context).size.width * 0.51,
                        height: MediaQuery.of(context).size.height * 0.25,
                        fit: BoxFit.cover,
                        cache: true,
                      ),/*CachedNetworkImage(
                          imageUrl: widget.heroTag,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                 ),
                            ),
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width * 0.51,
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
)*/)),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.3,
                  left: 25.0,
                  right: 25.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.Item.name,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold)),
                      widget.Item.name.contains('سلمون مدخن')
                          ? new Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.41,
                                  height: 30.0,
                                  child: ListTile(
                                    title: const Text('مستوى'),
                                    leading: Radio(
                                      value: 'مستوى',
                                      groupValue: _character,
                                      onChanged: (value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.41,
                                  height: 30.0,
                                  child: ListTile(
                                    title: const Text('نى'),
                                    leading: Radio(
                                      value: 'نى',
                                      groupValue: _character,
                                      onChanged: (value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                      autofocus: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 30.0),
                      Visibility(
                        visible: widget.isAdmin,
                        child: Row(
                          children: <Widget>[
                            Text(widget.Item.allquantity.toString(),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20.0,
                                    color: Colors.grey)),
                            SizedBox(width: 5),
                            GestureDetector(
                                onTap: () {
                                  showEditScreen(
                                      context, widget.Item.id, 'ادخل الكمية');
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Color(0xFF7A9BEE),
                                )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              (widget.Item.price - widget.Item.theOffer)
                                      .toString() +
                                  " جم",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20.0,
                                  color: Colors.grey)),
                          Visibility(
                            visible: widget.isAdmin,
                            child: GestureDetector(
                                onTap: () async {
                                  await showEditScreen(context, widget.Item.id,
                                      'ادخل السعر الجديد');
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Color(0xFF7A9BEE),
                                )),
                          ),
                          Container(
                              height: 25.0, color: Colors.grey, width: 1.0),
                          Container(
                            width: 125.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17.0),
                                color: Color(0xFF7A9BEE)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (widget.Item.name
                                          .contains('سلمون مدخن')) {
                                        if (quantity > 0.1) quantity -= 0.05;
                                      } else {
                                        if (quantity > 0.25) quantity -= 0.25;
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 25.0,
                                    width: 25.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        color: Color(0xFF7A9BEE)),
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(quantity.toString() + " " + "كيلو ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0)),
                                InkWell(
                                  onTap: () {
                                    List<orderitem> cart =
                                        fixedicon().createState().getCart;
                                    double sum = 0;
                                    cart.forEach((element) {
                                      if (element.id == widget.Item.id)
                                        sum += element.quantity;
                                    });
                                    print('--------------' +
                                        (sum + quantity).toString());
                                    setState(() {
                                      if (sum + quantity <
                                          widget.Item.allquantity) {
                                        if (widget.Item.name
                                            .contains('سلمون مدخن'))
                                          quantity += 0.05;
                                        else
                                          quantity += 0.25;
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "عفوا , لقد انتهى هذا المنتج",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 5,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 25.0,
                                    width: 25.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        color: Colors.white),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Color(0xFF7A9BEE),
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.027),
                      option(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.027),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (quantity != 0.0) {
                              if (!widget.edit)
                                fixedicon().createState().increasecart(
                                    orderitem(
                                        widget.Item.id,
                                        widget.heroTag,
                                        widget.Item.name,
                                        (widget.Item.price -
                                                widget.Item.theOffer) *
                                            quantity,
                                        widget.Item.category,
                                        quantity,
                                        false,
                                        optionName,
                                        optionPrice * quantity,
                                        widget.Item.theOffer,
                                        widget.Item.allquantity));
                              else {
                                fixedicon().createState().editcart(
                                    widget.index,
                                    orderitem(
                                        widget.Item.id,
                                        widget.heroTag,
                                        widget.Item.name,
                                        (widget.Item.price -
                                                widget.Item.theOffer) *
                                            quantity,
                                        widget.Item.category,
                                        quantity,
                                        false,
                                        optionName,
                                        optionPrice * quantity,
                                        widget.Item.theOffer,
                                        widget.Item.allquantity));
                                widget.refresh();
                                Navigator.pop(context);
                              }
                              setState(() {
                                quantity = 0.0;
                              });

                              print(
                                  ((widget.Item.price - widget.Item.theOffer) *
                                              quantity)
                                          .toString() +
                                      ' ' +
                                      (optionPrice * quantity).toString() +
                                      ' ');
                            } else {
                                        Fluttertoast.showToast(
                                            msg: " عفوا , ادخل الوزن المطلوب اولا",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 5,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(25.0)),
                              color: Colors.black),
                          height: 50.0,
                          child: Center(
                            child: Text(
                                "جم " +
                                    (quantity *
                                                (widget.Item.price -
                                                    widget.Item.theOffer) +
                                            optionPrice * quantity)
                                        .toString() +
                                    " " +
                                    " << اضف الي السله",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      )
                    ],
                  ))
            ])
          ])),
    );
  }

  Widget _buildInfoCard(String cardTitle, String info, String unit) {
    return InkWell(
        onTap: () {
          optionPrice = info == 'مجاني' ? 0.0 : double.parse(info);
          cardTitle == 'بدون' ? optionName = '' : optionName = cardTitle;
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color:
                  cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75),
            ),
            height: MediaQuery.of(context).size.height / 7,
            width: MediaQuery.of(context).size.height / 7,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(cardTitle,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          color: cardTitle == selectedCard
                              ? Colors.white
                              : Colors.grey.withOpacity(0.7),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(info,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14.0,
                                color: cardTitle == selectedCard
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(unit,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12.0,
                              color: cardTitle == selectedCard
                                  ? Colors.white
                                  : Colors.black,
                            ))
                      ],
                    ),
                  )
                ])));
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }

  refresh() {
    setState(() {
//all the reload processes
    });
  }

  showEditScreen(var context, String itemId, String helperText) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: EditProductModal(
                itemId: itemId,
                helperText: helperText,
              ),
            )));
  }
}
