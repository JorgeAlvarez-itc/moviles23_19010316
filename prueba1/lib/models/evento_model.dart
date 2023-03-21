class EventoModel {
  int? idEvento;
  String? dscEvento;
  String? fechaEvento;
  bool? completado;

  EventoModel({this.idEvento, this.dscEvento, this.fechaEvento, this.completado});

  factory EventoModel.fromMap(Map<String, dynamic> map) {
    return EventoModel(
      idEvento: map['idEvento'],
      dscEvento: map['dscEvento'],
      fechaEvento: map['fechaEvento'],
      completado: map['completado'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idEvento': idEvento,
      'dscEvento': dscEvento,
      'fechaEvento': fechaEvento,
      'completado': completado == true ? 1 : 0,
    };
  }
}
