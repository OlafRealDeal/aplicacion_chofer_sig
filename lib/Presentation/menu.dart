import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/Presentation/Layouts/header.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/searchs.dart';

class Menu extends StatefulWidget{
  const Menu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __MenuState();
  }

}

class __MenuState extends State<Menu>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Style().backgroundColor(),
      appBar: headerAppBar(context),
      drawer: SideNav(),
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              //appBackground(),
              SingleChildScrollView(
                child: todo(context),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget todo(BuildContext context) {
    return
      SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                searchBar(context,(context,action){  }),
              ],
            ),
          )
      );

  }

}

