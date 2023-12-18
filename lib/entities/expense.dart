import 'package:myfinances/entities/tag.dart';

class Expense{

  final String name;
  final int value;
  final Tag tag;
  final String pathFile;

  Expense({
    required this.name,
    required this.value,
    required this.tag,
    required this.pathFile,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      name: json['name'] ?? "",
      value: json['value'] ?? 0,
      tag: Tag.fromJson(json['tag']),
      pathFile: json['pathFile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'value': value,
    'tag': tag.toJson(),
    'pathFile': pathFile,
  };

  @override
  toString(){
    return 'name: $name,' ' value: $value,' ' tag: $tag,' 'pathFile: $pathFile,';
  }

}