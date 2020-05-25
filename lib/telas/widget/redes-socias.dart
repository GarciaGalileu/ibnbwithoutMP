import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igrejabatistanovabelem/config/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class RedesSociais extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RedeSocialWidget(
                icone: FontAwesomeIcons.facebook,
                url: 'https://www.facebook.com/IgrejaBatistaNovaBelem',
                urlapp: 'fb://page/1414985655468316',
              ),
              RedeSocialWidget(
                icone: FontAwesomeIcons.instagram,
                url: 'https://www.instagram.com/igrejabatistanovabelem',
                urlapp:
                    'intent://instagram.com/_u/igrejabatistanovabelem/#Intent;package=com.instagram.android;scheme=https;end',
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Igreja Batista Nova Belém",
                style: TextStyle(
                    color: Colors.black38, fontSize: 16, fontFamily: 'Lato'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RedeSocialWidget extends StatelessWidget {
  final icone;
  final url;
  final urlapp;
  const RedeSocialWidget({Key key, this.icone, this.url, this.urlapp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String fbProtocolUrl = urlapp;
        String fallbackUrl = url;

        try {
          bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

          if (!launched) {
            await launch(fallbackUrl, forceSafariVC: false);
          }
        } catch (e) {
          await launch(fallbackUrl, forceSafariVC: false);
        }
      },
      child: new Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 2, color: ibaPrimaryColor)),
          child: Icon(
            icone,
            color: ibaPrimaryColor,
          ),
        ),
      ),
    );
  }
}
