import 'package:flutter/material.dart';
import 'package:igrejabatistanovabelem/config/constants.dart';
import 'package:igrejabatistanovabelem/telas/formulario.dart';
import 'package:igrejabatistanovabelem/telas/widget/redes-socias.dart';

class TelaContribuicao extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TelaContribuicao();
  }
}

class _TelaContribuicao extends State<TelaContribuicao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: ContainerApp(),
        ),
      ),
    );
  }
}

class ContainerApp extends StatelessWidget {
  const ContainerApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(
                  "assets/img/logo-igreja.png",
                ),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "Faça a sua contribuição",
                    style: TextStyle(
                        color: ibaTextColor, fontSize: 40, fontFamily: 'Lato'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Esta é uma plataforma para todos que desejam semear no Reino de Deus através da devolução dos seus dízimos e ofertas na Igreja Batista Nova Belém de forma Segura e Prática por meio de Boleto, Débito ou Crédito",
                  style: TextStyle(
                      color: ibaTextColor, fontSize: 20, fontFamily: 'Lato'),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 380,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: FormularioContribuicao(),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 140,
                  decoration: BoxDecoration(
                    color: ibaTextColor,
                  ),
                  child: RedesSociais(),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
