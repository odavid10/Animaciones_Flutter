import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavegacionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notfications Page'),
          backgroundColor: Colors.pink,
        ),
        floatingActionButton: BotonFlotante(),
        bottonNavigationBar: BottonNavigation(),
      ), 
    );
  }
}

class BottonNavigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final int numero = Provider.of<_NotificationModel>(context).numero;

    return BottonNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.pink,
      items: [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.bone),
          title: Text('Bones'),
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.bell),
              Positioned(
                top: 0.0,
                right: 0.0,
                // child: Icon(Icons.brightness_1, size: 8, color: Colors.redAccent),
                child: BounceInDown(
                  from: 10,
                  animate: (numero > 0) ? true : false,
                  child: Bounce(
                    from: 10,
                    controller: (controller) => Provider.of<_NotificationModel>(context).bounceController = controller,
                    child: Container(
                      child: Text('${numero}', style: TextStyle(color: Colors.white, fontSize: 7)),
                      alignment: Alignment.center,
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ), 
                ), 
              ),
            ],
          ),
          title: Text('Notifications'),
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.dog),
          title: Text('My Dog'),
        ),
      ],
    );
  }
}

class BotonFlotante extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: FaIcon(FontAwesomeIcons.play),
      backgroundColor: Colors.pink,
      onPressed: (){

        final notiModel = Provider.of<_NotificationModel>(context, listen: false);
        int numero = notiModel.numero;
        
        numero++;

        notiModel.numero = numero;

        if(numero >= 2){
          final controller = notiModel.bounceController;

          controller.forward(from: 0.0);
        }
      },
    );
  }
}

class _NotificationModel extends ChangeNotifier {
  
  int _numero = 0;
  AnimationController _bounceController;

  int get numero => this._numero;

  set numero (int valor) {
    this._numero = valor;
    notifierListeners();
  }

  AnimationController get bounceController => this._bounceController;

  set bounceController (AnimationController controller) {
    this._bounceController = controller;
    notifierListeners();
  }

}