import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'config/constants.dart';
import 'package:flutter/material.dart';
import 'package:igrejabatistanovabelem/telas/contribuicao.dart';
void main() {
  runApp(Phoenix(child: Contribuicao()));
}

class Contribuicao extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        primaryColor: ibaPrimaryColor,
        scaffoldBackgroundColor: ibaBackgorundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: ibaTextColor),
        unselectedWidgetColor:Colors.white
      ),
      home: TelaContribuicao(),
    );
  }

}
