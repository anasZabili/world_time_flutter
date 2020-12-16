import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  /*
  void getTime() async {
    // make the request
    Response response = await get(
        'http://worldtimeapi.org/api/timezone/Europe/London');
    Map data = jsonDecode(response.body);
    print(data);
  }
  */


  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  void setupWorldTime() async {
    WorldTime worldTimeInstance = WorldTime(flag: 'uk_flag.png', url: 'Europe/London', location: 'UK');
    await worldTimeInstance.getTime();
    // methode tres important elle permet de push une nouvelle page sur la pile
    // de route en remplacent la precedente page qui se trouvait en sommet
    // de pile
    // ici le loading screen ne sera plus jamais utile cette methode va permettre
    // de le supprimer de la pile
    // le troisieme argument permet de passer des propriété de page en page
    // sois forme d'une map
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': worldTimeInstance.location,
      'time': worldTimeInstance.time,
      'flag': worldTimeInstance.flag,
      'isDayTime': worldTimeInstance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      )
    );
  }
}
