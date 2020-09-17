import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_fish/models/category.dart';
import 'package:fresh_fish/models/item.dart';
import 'package:fresh_fish/models/user.dart';
import 'package:fresh_fish/pages/ordersList.dart';
import 'package:fresh_fish/services/auth.dart';
import 'package:fresh_fish/services/database.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';
import 'package:provider/provider.dart';
import 'detailsPage.dart';
import 'items.dart';

class HomeScreen extends StatefulWidget {



   //HomeScreen({this.categorys});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  String _email;
  final textStyle = TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold);
  static List<category> _category;
 /* final List<String> categoryList = [
    "جمبرى لحم اماراتى",
    "جمبرى قشر أماراتى",
    "جمبرى بلدى",
    "كابوريا",
    "سبيط و اخطابوت",
    "جاندوفلى و بلح البحر",
    "جزل",
    "سلمون",
    "بطارخ",
    "سى فود",
    "فيليه",
    "استاكوزا",
    "الاسماك",
    "الطواجن",
    "الوجبات",
    "السندوتشات",
    "الارز",
    "شوربه",
    "السلطات",
  ];
  final List<String> imagesCategory=[
    "https://5.imimg.com/data5/BM/LW/MY-40538315/frozen-shrimp-pd-500x500.jpg",

    "https://kamelabdo.com/wp-content/uploads/2020/02/7-1.jpg",

    "https://inhabitat.com/wp-content/blogs.dir/1/files/2019/04/shrimp-lead.jpg",

    "https://kamelabdo.com/wp-content/uploads/2020/02/40-1.jpg",

    "https://kamelabdo.com/wp-content/uploads/2020/02/38-1.jpg",

    "https://images.unsplash.com/photo-1448043552756-e747b7a2b2b8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=949&q=80",

    "https://tonysmarket.com/wp-content/uploads/2017/03/ThinkstockPhotos-533985314.jpg",

    "https://p0.pikrepo.com/preview/834/625/sliced-fish-meat-on-white-surface.jpg",

    "https://www.italian-feelings.com/wp-content/uploads/2019/06/cid_3E213ACC-7341-4877-858A-BD557EAF7444.jpg",

    "https://images.unsplash.com/photo-1574653853117-0274131c2175?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80",

    "https://d2j6dbq0eux0bg.cloudfront.net/images/13995032/1409097998.jpg",

    "https://images.unsplash.com/photo-1590759668628-05b0fc34bb70?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80",

    "https://www.fishing.net.nz/default/cache/file/ABCE2B3C-0BA2-4347-C5DECA7D1DBF64FF.jpg",

    "https://media.linkonlineworld.com/img/large/2018/9/17/2018_9_17_14_2_18_819.jpg",

    "https://369t7u43n93dgc5pt43uc681-wpengine.netdna-ssl.com/wp-content/uploads/2017/06/Fish-in-Bulk-4-Easy-Quick-recipes.jpg",
    "https://www.fitness.com.hr/images/articles/7e80d98c-b2e2-4fb9-96c1-b75113007860.jpg",
    "https://images.deliveryhero.io/image/talabat/MenuItems/Seafood_Paella_637116705339759832.jpg",
    "https://kitchen.sayidaty.net/uploads/small/35/3598007db869f4c95c7a1dae6c6215f9_w750_h500.jpg",
    "https://www.crunchycreamysweet.com/wp-content/uploads/2019/03/overhead-shot-of-salmon-salad.jpg"
  ];
  List<String>imagesItem=[
   "https://i.ibb.co/qk5jTBw/13604398-a-plate-of-shrimp-cocktail-from-above-removebg-preview.png",

   "https://i.ibb.co/kSNChhN/800px-COLOURBOX3225621-removebg-preview.png",

    "https://i.ibb.co/tJjDdYh/39531-removebg-preview.png",

    "https://i.ibb.co/rsj8DQ1/122749060-gorgeous-seafood-platter-image-removebg-preview.png",

    "https://i.ibb.co/m5t8NZf/121851230-traditional-french-octopus-braised-cooked-with-salicornia-lemon-curd-and-spice-as-top-view.png",

    "https://i.ibb.co/d2F7HYP/DSC01035-removebg-preview.png",

    "https://i.ibb.co/47WRwKn/182704-1820-removebg-preview.png",

    "https://i.ibb.co/7tw7zs2/vzxn0ykh7ppilpjm9k7g-removebg-preview.png",

    "https://i.ibb.co/PCmfghy/71pb-S7-IHEi-L-SL1500-removebg-preview.png",

    "https://i.ibb.co/cL1kCMG/51248830-cioppino-1x1-removebg-preview.png",

    "https://i.ibb.co/bm35L52/Fish-Piccata-feature-2-removebg-preview.png",

    "https://i.ibb.co/ByRhFmX/IMG-1458-84ff71c8-0fc4-43cf-8072-0a4c62979af1-530x-2x-removebg-preview.png",

    "https://i.ibb.co/YDgbMsC/plate-filled-with-fresh-uncooked-seafood-fish-23-2148637889-removebg-preview.png",

    "https://i.ibb.co/GstrpTz/3-Tajine-Kefta-Pdt-removebg-preview.png",

    "https://i.ibb.co/t26Grf6/img-4380-810x810-removebg-preview.png",

     "https://i.ibb.co/t26Grf6/img-4380-810x810-removebg-preview.png",//sandwich

    "https://i.ibb.co/S5LZmW5/5790760526-9e7a973e05-removebg-preview.png",

    "https://i.ibb.co/dcnqyQC/new-england-fish-chowder-56105952-removebg-preview.png",

    "https://i.ibb.co/jDY2Whw/marketfish-article-740x1005-removebg-preview.png"

  ];*/


  final _textFieldController = TextEditingController();
  void Constractor(List<category> categorys){
       _category=categorys;
  }
  List<item> fillListofcategory(List<item> items) {
    /*for(int i=0;i<imagesItem.length;i++){
      print("category(\""+categoryList[i]+"\""+","+"\""+imagesCategory[i]+"\""+","+"\""+imagesItem[i]+"\"),");

    }*/
    List<item> Listofcategory = [];
    if (items != null) {
      for (int i = 0; i < items.length; i++) {
        if (items[i].Isoffered) {
          Listofcategory.add(items[i]);
        }
      }
    }
    return Listofcategory;
  }


  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<item>>(context);
    final uid = Provider.of<User>(context);
    final user = Provider.of<DocumentSnapshot>(context);
    if (user !=null && user.exists) {
      _email = user.data['email'];

    }
    List<item> Listofcategory = fillListofcategory(items);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: ()async {
              fixedicon().createState().cleancart();
              AuthService auth = AuthService();
              await auth.signOut();
            },
            child: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            )),
        elevation: 0.0,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Visibility(
                visible:_email == "fresh_fish@freshfish.com" ,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrdersList()));
                      },
                      child:
                          Icon(Icons.local_shipping, color: Colors.black))),
              fixedicon(order: false, refresh: refreshHome),
            ],
          ),
        ],
      ),
      body: ListView(children: <Widget>[
        Center(
          child: SizedBox(
            height: 200, // card height
            child: PageView.builder(
              itemCount: Listofcategory.length,
              controller: PageController(viewportFraction: 0.7),
              onPageChanged: (int index) => setState(() => _index = index),
              itemBuilder: (con, i) {
                return InkWell(
                  onTap: ()  {
                   // print(categoryList.indexOf(Listofcategory[i].category));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailsPage(
                            heroTag:_category[_category.indexWhere((element) => element.name==Listofcategory[i].category)].itemImage,
                            order: false,
                            refresh: refreshHome,
                            Item: Listofcategory[i],
                            isAdmin: _email == "fresh_fish@freshfish.com",)));
                  },
                  child: Transform.scale(
                    scale: i == _index ? 1 : 0.9,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding:EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center
                            ,children: [
                          Hero(
                              tag: i,
                              child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:CachedNetworkImageProvider(_category[_category.indexWhere((element) => element.name==Listofcategory[i].category)].itemImage),
                                          fit: BoxFit.cover)),
                                  height: 90.0,
                                  width: 90.0)),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(Listofcategory[i].name,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold)),
                                /*SizedBox(height: 1.0),*/
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                          Listofcategory[i]
                                                  .price
                                                  .toString() +
                                              " " +
                                              "جم",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 18.0,
                                              color: Colors.grey,
                                              decoration: TextDecoration
                                                  .lineThrough)),
                                      Text(
                                          (Listofcategory[i].price -
                                                      Listofcategory[i]
                                                          .theOffer)
                                                  .toString() +
                                              " " +
                                              "جم",
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 18.0,
                                            color: Colors.blue,
                                          ))
                                    ])
                              ]),
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.0, left: 20),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            child: TextField(
                controller: _textFieldController,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                cursorColor: Theme.of(context).primaryColor,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                  suffixIcon: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          /*fixedicon().createState().cleancart();
                                  await _auth.signOut();*/
                          if (_textFieldController.text.isNotEmpty) {
                            DatabaseService databaseService =
                                DatabaseService(uid: uid.uid);
                            List<item> result = await databaseService
                                .fetchSearchResult(_textFieldController.text);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => itemsPage(
                                    searchPage: true,
                                    email: _email,
                                    searchResult: result,
                                    refreshHome: refreshHome)));
                          }
                        },
                      )),
                  border: InputBorder.none,
                  hintText: "البحث",
                )),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.only(right: 20.0, left: 20),
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount:_category.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => itemsPage(
                            heroTag: _category[index].itemImage,
                            searchPage: false,
                            email: _email,
                            category: _category[index].name,
                            refreshHome: refreshHome)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: Stack(children: <Widget>[
                        Container(
                          height: 230.0,
                          width: 340.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:  CachedNetworkImageProvider(
                                      _category[index].categoryImage,
                                    ),

                                    fit: BoxFit.cover)),
                        ),
                        Positioned(
                          left: 0.0,
                          bottom: 0.0,
                          width: 340.0,
                          height: 60.0,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Colors.black, Colors.black12])),
                          ),
                        ),
                        Positioned(
                          left: 10.0,
                          bottom: 10.0,
                          right: 10.0,
                          child: Center(
                            child: Text(
                              _category[index].name,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              }),
        ),
      ]),
    );
  }

  refreshHome() {
    setState(() {
//all the reload processes
    });
  }
}
