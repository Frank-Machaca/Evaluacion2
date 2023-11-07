import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FincaModelo {
  FincaModelo({
    required this.id,
    required this.nombreRaza,
  });

  FincaModelo.unlaunched();

  late int id = 0;
  late final String nombreRaza;

  FincaModelo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombreRaza = json['nombreRaza'];
  }

  factory FincaModelo.fromJsonModelo(Map<String, dynamic> json) {
    return FincaModelo(
      id: json['id'],
      nombreRaza: json['nombreRaza'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombreRaza'] = nombreRaza;
    return _data;
  }
}
