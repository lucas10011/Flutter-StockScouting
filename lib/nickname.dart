

import 'package:flutter/material.dart';
import 'package:scouting/models/todo.dart';
import 'package:scouting/home_page.dart';
import 'package:scouting/models/state.dart';
import 'package:scouting/statewidget.dart';





class NicknamePage extends StatefulWidget {


  @override
  _NicknamePageState createState() => _NicknamePageState();
}




class _NicknamePageState extends State<NicknamePage> {
 


  @protected
  void initState() {


    super.initState();
  }

 
final TextEditingController nickname = new TextEditingController();
  StateModel appState;
  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    Size screenSize = MediaQuery.of(context).size;
    return  Scaffold(
            backgroundColor: AppColors.primary,
            appBar: AppBar(
              backgroundColor: AppColors.menu,
              title: Center(child: Text("Stock Scouting")),
              
            ),
            body:SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Icon(Icons.person, size: screenSize.height / 2.5,color: Colors.grey,),
                        SizedBox(height: screenSize.height / 20,),
                        TextFormField(
                            textAlign: TextAlign.center,
                            controller: nickname,
                            decoration: const InputDecoration(
                              hintText: 'Digite um nome para o backtest',
                              fillColor: Colors.white, filled: true
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenSize.height / 12,),
                          RaisedButton(
                                  shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black, Colors.black],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Avançar",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              appState.nickname = nickname.text;
                            });
                            Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) => HomePage(),
                                            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                            transitionDuration: Duration(milliseconds: 400),
                                          ),
                                        );
                          },
                          
                        ),
                         SizedBox(height: screenSize.height / 12,),
                      ],
                    ),
                  ),
                ),
              ),
            )
      );
    }
        
  }


