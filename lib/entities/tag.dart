import 'package:flutter/material.dart';

class Tag{

  final String name;
  final int color;

  Tag({
    required this.name,
    required this.color,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'] ?? "",
      color: json['color'] ?? 0,
    );
  }
  
  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'color': color,
  };

  @override
  toString(){
    return 'name: $name,' 'color: $color,';
  }

}