import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map recivedDataFromLoading = {};
  @override
  Widget build(BuildContext context) {
    // sert a recuperer les donner transmit pas le widget loading
    recivedDataFromLoading = recivedDataFromLoading.isNotEmpty
        ? recivedDataFromLoading
        : ModalRoute.of(context).settings.arguments;
    print(recivedDataFromLoading);

    // set backgroud
    String bgImage =
        recivedDataFromLoading['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor =
        recivedDataFromLoading['isDayTime'] ? Colors.blue : Colors.indigo[700];
    return Scaffold(
      backgroundColor: bgColor,
      // Safe area sert a afficher le text seulement dans des parti visible d
      // de lecran sans cela la text se retrouve caché sous la barre de
      // notification
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/$bgImage'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: [
              FlatButton.icon(
                  onPressed: () async {
                    // cette fonction sert a changer de route
                    // a stacker une nouvelle page sur la pile de navigation
                    // dans result ce trouve le resultat retourner pas la page ce situant au
                    // dessus de home ici la page choose location
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    print('the result is ............ $result');
                    setState(() {
                      this.recivedDataFromLoading = {
                        'time': result['time'],
                        'isDayTime': result['isDayTime'],
                        'location': result['location'],
                        'flag': result['flag'],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  )),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    recivedDataFromLoading['location'],
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20.0),
                  //Image.asset('assets/uk_flag.png'),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                recivedDataFromLoading['time'],
                style: TextStyle(
                  fontSize: 66.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
