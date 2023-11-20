import 'package:myfinances/entities/tag.dart';

class Expense{

  final String name;
  final int value;
  final Tag tag;

  Expense({
    required this.name,
    required this.value,
    required this.tag,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      name: json['name'] ?? "",
      value: json['value'] ?? 0,
      tag: Tag.fromJson(json['tag']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'value': value,
    'tag': tag.toJson(),
  };

  @override
  toString(){
    return 'name: $name,' ' value: $value,' ' tag: $tag,';
  }

}