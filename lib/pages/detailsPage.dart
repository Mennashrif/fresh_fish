import 'package:flutter/material.dart';
import 'package:fresh_fish/models/orderitem.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';

import 'items.dart';

class DetailsPage extends StatefulWidget {
  final heroTag;
  final foodName;
  final foodPrice;
  final order;
  final edit;
  final index;
  final refresh;
  final refreshHome;
  DetailsPage({this.heroTag, this.foodName, this.foodPrice,this.order,this.edit=false,this.index=0,this.refresh,this.refreshHome});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var selectedCard = 'WEIGHT';
  var quantity=0.25;
  var optionPrice=0.0;
  var optionName='';
  var re;
  var ed;
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
            title: Text('Details',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18.0,
                    color: Colors.white)),
            centerTitle: true,
            actions: <Widget>[
              widget.edit?new Container():fixedicon(order: widget.order,refresh: widget.order?widget.refresh:refresh,refreshHome:widget.refreshHome),
            ],


          ),

          body: ListView(children: [
            Stack(children: [
              Container(
                  height: MediaQuery.of(context).size.height - 82.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent),
              Positioned(
                  top: 75.0,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45.0),
                            topRight: Radius.circular(45.0),
                          ),
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height - 100.0,
                      width: MediaQuery.of(context).size.width)),
              Positioned(
                  top: 30.0,
                  left: (MediaQuery.of(context).size.width / 2) - 100.0,
                  child: Hero(
                      tag: widget.heroTag,
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(widget.heroTag),
                                  fit: BoxFit.cover)),
                          height: 200.0,
                          width: 200.0))),
              Positioned(
                  top: 250.0,
                  left: 25.0,
                  right: 25.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.foodName,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(widget.foodPrice.toString()+" "+"L.e",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20.0,
                                  color: Colors.grey)),
                          Container(height: 25.0, color: Colors.grey, width: 1.0),
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
                                      if(quantity>0.25)
                                          quantity-=0.25;
                                    });
                                  },
                                  child: Container(
                                    height: 25.0,
                                    width: 25.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7.0),
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
                                Text(quantity.toString()+" "+"Kg",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0)),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      quantity+=0.25;
                                    });
                                  },
                                  child: Container(
                                    height: 25.0,
                                    width: 25.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7.0),
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
                      SizedBox(height: 20.0),
                      Container(
                          height: 150.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              _buildInfoCard('قلي', '5', 'L.e'),
                              SizedBox(width: 10.0),
                              _buildInfoCard('شوي', '5', 'L.e'),
                              SizedBox(width: 10.0),
                              _buildInfoCard('سنجاري', '10', 'L.e'),
                              SizedBox(width: 10.0),
                              _buildInfoCard('بدون', '0', 'L.e')
                            ],
                          )
                      ),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: (){
                           setState(() {
                               if(!widget.edit)
                                fixedicon().createState().increasecart(orderitem(widget.foodName, widget.foodPrice,quantity,false,optionName,optionPrice));
                               else {
                                 fixedicon().createState().editcart(
                                     widget.index, orderitem(
                                     widget.foodName, widget.foodPrice,
                                     quantity, false, optionName, optionPrice));
                                     widget.refresh();
                                     Navigator.pop(context);
                               }

                             });
                        },

                        child: Padding(
                          padding: EdgeInsets.only(bottom:5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0), bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0)),
                                color: Colors.black
                            ),
                            height: 50.0,
                            child: Center(
                              child: Text(
                              (quantity*widget.foodPrice+optionPrice).toString()+" "+"L.e",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat'
                                  )
                              ),
                            ),
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
          optionPrice=double.parse(info);
          cardTitle=='بدون'?optionName='':optionName=cardTitle;
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard ?
                  Colors.transparent :
                  Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75
              ),

            ),
            height: 100.0,
            width: 100.0,
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
                          color:
                          cardTitle == selectedCard ? Colors.white : Colors.grey.withOpacity(0.7),
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
                ]
            )
        )
    );
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
}