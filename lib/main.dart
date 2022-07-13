import 'package:flutter/material.dart';
import 'package:aplicacion_chofer_sig/Middleware/middleware.dart';
import 'package:aplicacion_chofer_sig/Presentation/404.dart';
import 'package:aplicacion_chofer_sig/route_generator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await loadMiddleware();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: loginRoute(),
      onGenerateRoute: RouteGenerator.generateRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => const Error404()
              //settings.name
      ),
    );
  }
}

