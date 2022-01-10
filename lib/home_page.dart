
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:scouting/models/todo.dart';

import 'package:scouting/stock_page.dart';
import 'package:scouting/widgets/transitionpage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scouting/provider/function.dart';






class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}




class _HomePageState extends State<HomePage> {

  // HttpService httpService = HttpService();
  String listurl;


 


  @protected
  void initState() {

    // listurl = HttpService.getListUrl();
    super.initState();
  }

 


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: FunctionStock.parseJsonNameFromAssets('assets/stockjson/stocks.json'),
          builder: (BuildContext context, AsyncSnapshot<List<StockName>> snapshot) {
            if (snapshot.hasData) {
             return Scaffold(
                backgroundColor:AppColors.primary,
                appBar: AppBar(
                  backgroundColor: AppColors.menu,
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {
                        showSearch(context: context, delegate: Search(snapshot.data));
                      },
                      icon: Icon(Icons.search,size: 25,),
                    )
                  ],
                  centerTitle: true,
                  title: Text('Ações'),
                ),
                body: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => Slidable(
                     actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                        secondaryActions: <Widget>[
                          snapshot.data[index].name == "DOLFUT" 
                          ?
                          IconSlideAction(
                            caption: 'M5',
                            color: Colors.black45,
                            icon: Icons.event,
                            onTap: () {
                                String assetsPath = 'assets/stockjson/M5/${snapshot.data[index].name}.json';
                                Navigator.push(context, TransitionPageRoute(page:StockPage(stockname:snapshot.data[index].name,assetsPath: assetsPath)));
                            },
                          )
                          :
                          Container()
                        ],
                      child: Card(
                        elevation: 5,
                        child: Container(
                          decoration: new BoxDecoration (
                            gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Color.fromRGBO(0, 29, 45, 0.8), Color.fromRGBO(0, 29, 45, 1)]),
                          ),
                          child: ListTile(
                          leading: Hero(
                            tag: snapshot.data[index].name,
                            child: CircleAvatar(
                            radius: 30.0,
                            child: ClipOval(child:Image(image: AssetImage('assets/images/BOV_${snapshot.data[index].name}.png')) ,),
                            backgroundColor: Colors.transparent,
                            ),),
                            title: Center(
                              child: Text(snapshot.data[index].name,
                                            style: TextStyle(
                                                    fontSize: 20.0, 
                                                    color: Colors.white)),
                            ),
                              onTap: () {
                              String assetsPath = 'assets/stockjson/${snapshot.data[index].name}.json';
                              Navigator.push(context, TransitionPageRoute(page:StockPage(stockname:snapshot.data[index].name,assetsPath: assetsPath)));
                            },
                            
                          ),
                        ),
                    ),
                  ),
                  ),
              );
            
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        );
    }
        
  }


class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<StockName> listExample;
  Search(this.listExample);

  List<StockName> recentList = [
    StockName(name:"VALE3"),
    StockName(name:"ITUB4"),
    ];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<StockName> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.name.contains(query.toUpperCase()),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index].name,
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
                String assetsPath = 'assets/stockjson/${suggestionList[index].name}.json';
                Navigator.push(context, TransitionPageRoute(page:StockPage(stockname:suggestionList[index].name,assetsPath: assetsPath)));
                    },
        );
      },
    );
  }
}