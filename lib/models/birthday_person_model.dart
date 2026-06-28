import 'package:equatable/equatable.dart';

// Person shown in Today Birthday and Anniversary cards in right panel
// isBirthday flag differentiates which card this person appears in
class BirthdayPersonModel extends Equatable {
  final String id;
  final String name;
  final int avatarColorHex; // ARGB int — converted to Color in view layer
  final DateTime date; // actual birthday or anniversary date
  final bool isBirthday; // true = birthday card, false = anniversary card

  const BirthdayPersonModel({
    required this.id,
    required this.name,
    required this.avatarColorHex,
    required this.date,
    required this.isBirthday,
  });

  BirthdayPersonModel copyWith({
    String? id,
    String? name,
    int? avatarColorHex,
    DateTime? date,
    bool? isBirthday,
  }) {
    return BirthdayPersonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarColorHex: avatarColorHex ?? this.avatarColorHex,
      date: date ?? this.date,
      isBirthday: isBirthday ?? this.isBirthday,
    );
  }

  @override
  List<Object?> get props => [id, name, avatarColorHex, date, isBirthday];
}