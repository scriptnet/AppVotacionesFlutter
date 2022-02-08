import 'dart:io';

import 'package:app_1_0/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // LISTA
  List<Band> bands = [
    Band(id: '1', name: 'Alex', votes: 2),
    Band(id: '2', name: 'Carlos', votes: 3),
    Band(id: '3', name: 'Fernando', votes: 1),
    Band(id: '4', name: 'Willy', votes: 5)
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Nombres Banda', style: TextStyle(color: Colors.black87) ),
      backgroundColor: Colors.white,
      elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: ( context,  i) =>

         _bandtile(bands[i])

       ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand 
        ),
   );
  }
// METODO
  Widget _bandtile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('ID: ${band.id}');
        // LLAMAR EL BORRADO EN EL SERVER
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Eliminar', style: TextStyle(color: Colors.white)),
        )
      ),
      child: ListTile(
          leading: CircleAvatar(
            child: Text(band.name.substring(0,2)),
            backgroundColor: Colors.blue[100],
            ),
          title: Text(band.name),
          trailing: Text('${ band.votes }', style: TextStyle(fontSize: 20)),
          onTap: () {
            print(band.name);
          },
        ),
    );
  }


  // METODO
  addNewBand(){

    final textController = new TextEditingController();
    if ( Platform.isAndroid ) {
      // si la plataforma es Android
        return showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              title: Text('Agregar Item'),
              content: TextField(
                controller: textController,
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text('Agregar'),
                  textColor: Colors.blue,
                  elevation: 5,
                  onPressed: () => addBandTList(textController.text)
                  )
              ],
            );
          },
      );
    }

    showCupertinoDialog(
      context: context, 
      builder: ( _ ) {
        return CupertinoAlertDialog(
          title: Text('Agregar nuevo'),
          content: CupertinoTextField(
            controller: textController
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true, //cuando presionemos enter para q dispare la accion
              child: Text('Agregar'),
              onPressed: () => addBandTList(textController.text),
            ),
             CupertinoDialogAction(
              isDefaultAction: true, //cuando presionemos enter para q dispare la accion
              child: Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      }
      );
  
  }


  // metodo

  void addBandTList(String name) {
    print(name);
    if (name.length > 1) {
      // agregamos
      this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 1));
      setState(() {});
    }
    Navigator.pop(context);
  }
}