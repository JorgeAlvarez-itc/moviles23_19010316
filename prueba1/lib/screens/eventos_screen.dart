import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:prueba1/models/evento_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:prueba1/database/database_helper.dart';

class EventosScreen extends StatefulWidget {
  @override
  _EventosScreenState createState() => _EventosScreenState();
}

class _EventosScreenState extends State<EventosScreen> {
  Map<DateTime, List<EventoModel>>? selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DatabaseHelper? database;
  bool isCalendarView = true;
  EventoModel? evento;

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
    database = DatabaseHelper();
  }

  List<EventoModel> _getEventsfromDay(DateTime date) {
    return selectedEvents![date] ?? [];
  }

  Future<List<EventoModel>> _getEventsfromDayList(DateTime date) async {
    final eventos =
        await database!.getEventsForDay(date.toIso8601String() + 'Z');
    if (eventos != null && eventos.isNotEmpty) {
      return eventos;
    } else {
      return [];
    }
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EVENTOS ITC"),
        centerTitle: true,
        actions: [
          IconButton(
            icon:
                isCalendarView ? Icon(Icons.list) : Icon(Icons.calendar_today),
            onPressed: () {
              setState(() {
                isCalendarView = !isCalendarView;
              });
            },
          )
        ],
      ),
      body: FutureBuilder<List<EventoModel>>(
        future: database!.getAllEventos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            selectedEvents = {};
            for (var evento in snapshot.data!) {
              DateTime fechaEvento = DateTime.parse(evento.fechaEvento!);
              if (selectedEvents![fechaEvento] == null) {
                selectedEvents![fechaEvento] = [];
              }
              selectedEvents![fechaEvento]!.add(evento);
            }
            return isCalendarView
                ? Column(
                    children: [
                      TableCalendar(
                        focusedDay: selectedDay,
                        firstDay: DateTime(1990),
                        lastDay: DateTime(2050),
                        calendarFormat: format,
                        onFormatChanged: (CalendarFormat _format) {
                          setState(() {
                            format = _format;
                          });
                        },
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        daysOfWeekVisible: true,

                        //Day Changed
                        onDaySelected: (DateTime selectDay, DateTime focusDay) {
                          setState(() {
                            selectedDay = selectDay;
                            focusedDay = focusDay;
                          });
                        },
                        selectedDayPredicate: (DateTime date) {
                          return isSameDay(selectedDay, date);
                        },

                        eventLoader: _getEventsfromDay,
                        //To style the Calendar
                        calendarStyle: CalendarStyle(
                          isTodayHighlighted: true,
                          selectedDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          selectedTextStyle: TextStyle(color: Colors.white),
                          todayDecoration: BoxDecoration(
                            color: Colors.purpleAccent,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          defaultDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          weekendDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),

                        headerStyle: HeaderStyle(
                          formatButtonVisible: true,
                          titleCentered: true,
                          formatButtonShowsNext: false,
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          formatButtonTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, date, events) {
                            BoxDecoration? decoration;
                            TextStyle? textStyle;
                            if (events.isNotEmpty) {
                              int daysDifference =
                                  date.difference(DateTime.now()).inDays;
                              EventoModel eventito = events[0] as EventoModel;
                              bool? completado = eventito.completado;
                              if (daysDifference == 0 && !completado!) {
                                // Event is today
                                decoration = BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.green,
                                );
                                textStyle = TextStyle(color: Colors.white);
                              } else if (daysDifference == 1 ||
                                  daysDifference == 2) {
                                // Event is in 1 or 2 days
                                decoration = BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.yellow,
                                );
                              } else if (daysDifference < 0 && !completado!) {
                                // Event has passed and not completed
                                decoration = BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.red,
                                );
                                textStyle = TextStyle(color: Colors.white);
                              }
                            }
                            return Container(
                              width: 22,
                              height: 22,
                              decoration: decoration,
                              child: Center(
                                child: Text(
                                    events.isNotEmpty ? '${date.day}' : '',
                                    style: textStyle),
                              ),
                            );
                          },
                        ),
                      ),
                      ..._getEventsfromDay(selectedDay).map(
                        (EventoModel event) => ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  event.dscEvento.toString(),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.visibility),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/modify',
                                          arguments: event)
                                      .then((value) {
                                    setState(() {
                                      Navigator.pushNamed(context, '/eventos');
                                    });
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text('Confirmar borrado'),
                                            content:
                                                Text('Deseas borrar el post?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    database!
                                                        .DELETE(
                                                            'tblEvento',
                                                            event.idEvento!,
                                                            'idEvento')
                                                        .then((value) {
                                                      setState(() {});
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('SI')),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('No'))
                                            ],
                                          ));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 30, // número de días a mostrar en la lista
                          itemBuilder: (context, index) {
                            final day =
                                DateTime.now().add(Duration(days: index));
                            final fecha = DateFormat('yyyy-MM-dd').format(day);
                            return FutureBuilder<List<EventoModel>>(
                              future:
                                  _getEventsfromDayList(DateTime.parse(fecha)),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // muestra un indicador de carga mientras se espera el resultado
                                }

                                final events = snapshot.data ?? [];
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        DateFormat('EEEE, MMMM d').format(day),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (events.isNotEmpty)
                                      ...events.map(
                                        (event) => ListTile(
                                          title: Row(
                                            children: [
                                              Text(event.dscEvento.toString()),
                                              IconButton(
                                                icon: Icon(Icons.visibility),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                          context, '/modify',
                                                          arguments: event)
                                                      .then((value) {
                                                    setState(() {
                                                      Navigator.pushNamed(
                                                          context, '/eventos');
                                                    });
                                                  });
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    'Confirmar borrado'),
                                                                content: Text(
                                                                    'Deseas borrar el post?'),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        database!
                                                                            .DELETE(
                                                                                'tblEvento',
                                                                                event.idEvento!,
                                                                                'idEvento')
                                                                            .then((value) {
                                                                          setState(
                                                                              () {});
                                                                        });
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'SI')),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'No'))
                                                                ],
                                                              ));
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (events.isEmpty)
                                      ListTile(
                                        title: Text(
                                            'No hay eventos para este día.'),
                                      ),
                                    Divider(),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return Center(
              child: Text("No events found."),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Event"),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Save"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                    print("Event name cannot be empty");
                  } else {
                    final evento = EventoModel(
                        dscEvento: _eventController.text,
                        fechaEvento: selectedDay.toIso8601String(),
                        completado: false);
                    database!.INSERT('tblEvento', evento.toMap());
                    _eventController.clear();
                    Navigator.pop(context);
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
