// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agro_millets/models/millet_item.dart';

class OrderItem {
  final String item;
  final int count;

  OrderItem({
    required this.item,
    required this.count,
  });


  OrderItem copyWith({
    String? item,
    int? count,
  }) {
    return OrderItem(
      item: item ?? this.item,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item': item,
      'count': count,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      item: map['item'] as String,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) => OrderItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderItem(item: $item, count: $count)';

  @override
  bool operator ==(covariant OrderItem other) {
    if (identical(this, other)) return true;
  
    return 
      other.item == item &&
      other.count == count;
  }

  @override
  int get hashCode => item.hashCode ^ count.hashCode;
}
