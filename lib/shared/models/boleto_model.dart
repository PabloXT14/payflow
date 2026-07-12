import 'dart:convert';
import 'package:uuid/uuid.dart';

class BoletoModel {
  static const _uuid = Uuid();

  final String id;
  final String? name;
  final String? dueDate;
  final double? value;
  final String? barcode;
  final bool? paid;

  BoletoModel({
    String? id,
    this.name,
    this.dueDate,
    this.value,
    this.barcode,
    this.paid = false,
  }) : id = id ?? _uuid.v4();

  BoletoModel copyWith({
    String? id,
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
    bool? paid,
  }) {
    return BoletoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      value: value ?? this.value,
      barcode: barcode ?? this.barcode,
      paid: paid ?? this.paid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dueDate': dueDate,
      'value': value,
      'barcode': barcode,
      'paid': paid,
    };
  }

  factory BoletoModel.fromMap(Map<String, dynamic> map) {
    return BoletoModel(
      id: map['id'],
      name: map['name'],
      dueDate: map['dueDate'],
      value: map['value']?.toDouble(),
      barcode: map['barcode'],
      paid: map['paid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BoletoModel.fromJson(String source) =>
      BoletoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BoletoModel(name: $name, dueDate: $dueDate, value: $value, barcode: $barcode, paid: $paid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoletoModel &&
        other.name == name &&
        other.dueDate == dueDate &&
        other.value == value &&
        other.barcode == barcode &&
        other.paid == paid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        dueDate.hashCode ^
        value.hashCode ^
        barcode.hashCode ^
        paid.hashCode;
  }
}
