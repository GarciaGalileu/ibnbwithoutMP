import 'package:flutter/material.dart';
//import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:igrejabatistanovabelem/config/constants.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
//import 'package:mercadopago_sdk/mercadopago_sdk.dart';
//import 'package:edge_alert/edge_alert.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormularioContribuicao extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormularioContribuicao();
  }
}

class _FormularioContribuicao extends State<FormularioContribuicao> {
  FocusNode _focusNode;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String valor;
  
  int selectRadio;
  int buttonState;
  @override
  void initState() {
    super.initState();
   /*  const canalMercadoPagoResposta =
    const MethodChannel("ibnb.com/mercadoPagoResposta");
    canalMercadoPagoResposta.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'mercadoPagoOK':
          var idPagamento = call.arguments[0];
          var statusPagamento = call.arguments[1];
          var detalhesPagamento = call.arguments[2];
          Phoenix.rebirth(context);
          return mercadoPagoSucesso(
              idPagamento, statusPagamento, detalhesPagamento);
        case 'mercadoPagoError':
          var error = call.arguments[0];
          Phoenix.rebirth(context);
          return mercadoPagoErro(error);
      }
    }); */
    selectRadio = 0;
    buttonState = 0;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  setSelectRadio(int val) {
    setState(() {
      selectRadio = val;
    });
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  _textField({String labelText}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: TextFormField(
        onSaved: (String value) {
          valor = value;
        },
        validator: _validateValor,
        focusNode: _focusNode,
        onTap: _requestFocus,
        style: TextStyle(color: Colors.white, fontSize: 22),
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          RealInputFormatter(centavos: true),
        ],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: _focusNode.hasFocus ? "Digite o valor" : "R\$ 0,00",
          labelStyle: TextStyle(color: ibaTextColor),
          fillColor: ibaTextColor,
          border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0),),
          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0),),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0),),
          errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2.0),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "INFORMAÇÕES DA CONTRIBUIÇÃO",
                style: TextStyle(
                    color: ibaTextColor, fontSize: 22, fontFamily: 'Lato'),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 25, left: 10),
              child: Text(
                "Qual a sua contribuição?",
                style: TextStyle(
                    color: ibaTextColor, fontSize: 20, fontFamily: 'Lato'),
              ),
            ),
            new Row(
              children: <Widget>[
                new Radio(
                  activeColor: Colors.white,
                  value: 1,
                  groupValue: selectRadio,
                  onChanged: (val) {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    setSelectRadio(val);
                  },
                ),
                new Text(
                  'Dízimo',
                  style: new TextStyle(fontSize: 16.0, color: ibaTextColor),
                ),
                new Radio(
                    activeColor: Colors.white,
                    value: 2,
                    groupValue: selectRadio,
                    onChanged: (val) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      setSelectRadio(val);
                    }),
                new Text(
                  'Oferta',
                  style: new TextStyle(fontSize: 16.0, color: ibaTextColor),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 25, left: 10),
              child: _textField(),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: ibaPrimaryColor,
                onPressed: _validateInputs,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: const BoxDecoration(),
                  child: Center(
                    child:
                        Text(buttonState == 0 ? 'CONFIRMAR' : 'PROCESSANDO...'  ,
                            style: new TextStyle(
                              fontSize: 20.0,
                              color: ibaTextColor,
                            ),
                            textAlign: TextAlign.center) ,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _validateValor(String value) {
    if (value.isEmpty) {
      return 'Digite o valor da contribuição';
    }
    return null;
  }

  void _validateInputs() {
    setState(() => buttonState = 1);
    final form = _formKey.currentState;
    if (form.validate()) {
      if (selectRadio == 0) {
        setState(() => buttonState = 0);
        _showSnackBar('Selecione o tipo de contribuição');
      } else {
        // TODOS OS DADOS DO FORMULARIO SÃO VÁLIDOS
        // O PRÓXIMO PASSO É REALIZAR A INTEGRAÇÃO COM O MERCADO PAGO
        form.save();
/*         mercadoPago(valor.replaceAll(',', '.'), selectRadio);
 */      }
    } else {
      setState(() => buttonState = 0);
      setState(() => _autoValidate = true);
    }
  }

  void _showSnackBar(message) {
    final snackBar = new SnackBar(
      content: new Text(
        message,
        style: new TextStyle(
          fontSize: 14.0,
          color: ibaTextColor,
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

/*   Future<Map<String, dynamic>> preferencia(valor, tipo) async {
    var mp = MP(clientID, clientSecret);
    var preference = {
      "items": [
        {
          "title": tipo == 1 ? "DEPÓSITO DO DÍZIMO" : "DEPÓSITO DA OFERTA",
          "quantity": 1,
          "currency_id": "BRL",
          "unit_price": double.tryParse(valor)
        }
      ],
      "payer": {"email": "email@email.com"}
    };
    try {
    var result = await mp.createPreference(preference);

    return result;
    } catch (e) {
      setState(() => buttonState = 0);
      EdgeAlert.show(context, title: 'Ocorreu um erro ao realizar o processamento', description: 'Por favor verifique a sua conexão com a internet', gravity: EdgeAlert.BOTTOM, duration: EdgeAlert.LENGTH_LONG, backgroundColor:	Colors.red, icon: FontAwesomeIcons.infoCircle);  
    }
  }

  Future<void> mercadoPago(valor, tipo) async {
    preferencia(valor, tipo).then((result) {
      if (result != null) {
        var preferenceId = result['response']['id'];

        try {
          const canalMercadoPago = const MethodChannel("ibnb.com/mercadoPago");
          final response = canalMercadoPago.invokeMethod(
            "mercadoPago", <String, dynamic>{
            "publicKey": publicKey,
            "preferenceId": preferenceId
          });
          print(response);
        } on PlatformException catch (e) {
          print(e.message);
        }
      }
    });
  }

  void mercadoPagoSucesso(idPagamento, statusPagamento, detalhesPagamento) {
    print("ID DO PAGAMENTO: $idPagamento");
    print("STATUS DO PAGAMENTO: $statusPagamento");
    print("DETALHES DO PAGAMENTO: $detalhesPagamento");
  }

  void mercadoPagoErro(error) {
    print("ERRO DO PAGAMENTO: $error");
  } */
}
