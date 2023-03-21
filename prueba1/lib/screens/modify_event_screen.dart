import '../models/evento_model.dart';
import 'package:flutter/material.dart';
import 'package:prueba1/database/database_helper.dart';


class ModifyEvent extends StatefulWidget {
  const ModifyEvent({Key? key}) : super(key: key);

  @override
  _ModifyEventState createState() => _ModifyEventState();
}

class _ModifyEventState extends State<ModifyEvent> {
  EventoModel? event;
  DatabaseHelper database= DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    final txtdscEvent = TextEditingController();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      event = ModalRoute.of(context)!.settings.arguments as EventoModel;
      txtdscEvent.text = event!.dscEvento.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar evento'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Descripción del evento:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: txtdscEvent,
                maxLines: 5,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Completado:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: event!.completado!,
                    onChanged: (value) {
                      setState(() {
                        event!.completado = value;
                        event!.dscEvento=txtdscEvent.text.toString();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      database!.UPDATE(
                              'tblEvento',
                              {
                                'idEvento': event!.idEvento,
                                'dscEvento': txtdscEvent.text.toString(),
                                'fechaEvento':event!.fechaEvento,
                                'completado': event!.completado,
                              },
                              'idEvento')
                          .then((value) {
                        var msg = value > 0
                            ? 'Registro modificado'
                            : 'Ocurrio un error';
                        var snackBar = SnackBar(content: Text(msg));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Guardar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
