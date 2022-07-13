import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/Business/UserBusiness.dart';
import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Session/UserSession.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/dialog.dart';
import 'package:aplicacion_chofer_sig/assets/widgets/styles.dart';

import 'package:aplicacion_chofer_sig/route_generator.dart';

class SideNav extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return __SideNavState();
  }

}

class __SideNavState extends State<SideNav>{

  UserBusiness userBusiness=new UserBusiness();

  List<Widget> listaDeCards=List.generate(0, (index) =>SizedBox(height: 1,));

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Usuario: '+UserSession.user.name
              ,style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            Divider(
              color: Colors.green.shade300,
            ),
            // cardRoute(context,'User', () { Navigator.pushNamed(context, userAllRoute() ); } ),
            cardRoute(context,'Chofer', () { Navigator.pushNamed(context, choferAllRoute() ); } ),
            // cardRoute(context,'BusRoute', () { Navigator.pushNamed(context, busrouteAllRoute() ); } ),
            // cardRoute(context,'EntryPoint', () { Navigator.pushNamed(context, entrypointAllRoute() ); } ),
            // cardRoute(context,'ExitPoint', () { Navigator.pushNamed(context, exitpointAllRoute() ); } ),
            cardRoute(context,'Bus', () { Navigator.pushNamed(context, busAllRoute() ); } ),
            cardRoute(context,'Photo', () { Navigator.pushNamed(context, photoAllRoute() ); } ),
            // cardRoute(context,'Location', () { Navigator.pushNamed(context, locationAllRoute() ); } ),

            cardLogout(context),
          ],
        ),
      ),
    );
  }

  Widget cardLogout(BuildContext context){
    return ListTile(
      title: Text('Cerrar sesion'),
      trailing: Icon(Icons.logout),
      onTap: () async{

        DataResponse dataResponse=await userBusiness.logout();
        setState(() {
          hideOpenDialog(context);
          if (dataResponse.status){
            Navigator.pushNamedAndRemoveUntil(context,loginRoute(), (Route<dynamic> route) => false);
          }else{
            showAlertDialog(context, "Error al cerrar sesion", dataResponse.message);
          }
        });
      },
    );
  }

  Widget cardRoute(BuildContext context,String text, VoidCallback action){
    return ListTile(
      title: Text(text),
      trailing: Icon(Icons.chevron_right),
      onTap: () async{
        action();
      },
    );
  }

}

PreferredSizeWidget headerAppBar(BuildContext context){
  return AppBar(
    backgroundColor: Style().backgroundColor(),
    elevation: 0,
    titleSpacing: 0.0,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          color: Style().primaryColor(),
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

      ],
    ),
  );
}


Widget navigationHeader(BuildContext context,String title){
  return Container(
    color: Style().seccondaryColor(),
    width: MediaQuery.of(context).size.width,
    height: 50,
    child: Row(
      children: [
        SizedBox(width: 20,),
        Icon(Icons.home,color: Style().primaryColor(),),
        SizedBox(width: 20,),
        Icon(Icons.chevron_right,color: Style().uiColor(),),
        SizedBox(width: 20,),
        Text(title,style: TextStyle(color: Style().primaryColor(),fontSize: 20 ),)
      ],
    ),
  );
}
