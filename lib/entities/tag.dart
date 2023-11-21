class Tag{

  final String name;
  final int color;
  final double totalValue;

  Tag({
    required this.name,
    required this.color,
    required this.totalValue,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'] ?? "",
      color: json['color'] ?? 0,
      totalValue: json['totalValue'] ?? 0,
    );
  }
  
  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'color': color,
    'totalValue': totalValue,
  };

  @override
  toString(){
    return 'name: $name,' 'color: $color, totalValue: $totalValue';
  }

}