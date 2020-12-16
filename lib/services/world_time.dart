import 'package:http/http.dart';
// ce package sert a decoder les donnée json
import 'dart:convert';
// ce package sert a formater la date
import 'package:intl/intl.dart';


class WorldTime {
  // location name for the UI
  String location;
  String time; // time in that location
  String flag; // the url to an assets flag icon
  String url; // the url of the time api
  bool isDayTime; // true if its day

  WorldTime({this.location, this.flag, this.url});
  // on fait en sorte que cette fonction retourne
  // un objet de type futur pour que la fonction puisse
  // etre attendu dans dautre classe
  Future<void> getTime() async  {
    try {
      // l'objet response est fourni par le http package
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      // la reponse recu est un paquet de données au format json
      // pour decoder les donnes recu aun format json on utilse la fonction
      // jsonDecode fonction prevenant du paquet dart:conver
      // jsonDecode nous renvoie une map
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from data

      String dateTime =  data['datetime'];
      // on utilise substring pour osoler lentier representant les heur
      String offset = data['utc_offset'].substring(1, 3);

      // dateTime est un objet dart la methode parse permet
      // de convertir un string representant une date en objet dateTime
      DateTime now = DateTime.parse(dateTime);
      //print('lheur sans le offset etait $now');
      // int.parse convertion un string en int
      // add est non destructive
      now = now.add(Duration(hours: int.parse(offset)));
      //print('l\'heur actuelle est : $now');
      // now.add(Duration(hours: ))

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      // set the time property
      this.time = DateFormat.jm().format(now);
      // this.time = now.toString();
    } catch(e) {
      print('caught error: $e');
      this.time = 'could not get time data';
    }
  }
}