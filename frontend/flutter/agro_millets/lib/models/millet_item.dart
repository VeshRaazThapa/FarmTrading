// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MilletItem {
  final String id;
  final String name;
  final String category;
  final String listedBy;
  final String description;
  final double price;
  final double quantity;
  final List<dynamic> images;
  final DateTime listedAt;

  MilletItem({
    required this.id,
    required this.name,
    required this.listedBy,
    required this.description,
    required this.category,
    required this.price,
    required this.quantity,
    required this.images,
    required this.listedAt,
  });

  MilletItem copyWith({
    String? id,
    String? name,
    String? listedBy,
    String? description,
    String? category,
    double? price,
    double? quantity,
    List<dynamic>? images,
    DateTime? listedAt,
  }) {
    return MilletItem(
      id: id ?? this.id,
      name: name ?? this.name,
      listedBy: listedBy ?? this.listedBy,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      listedAt: listedAt ?? this.listedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'listedBy': listedBy,
      'description': description,
      'category': category,
      'price': price,
      'quantity': quantity,
      'images': images,
      'listedAt': listedAt.toIso8601String(),
    };
  }

  factory MilletItem.fromMap(Map<String, dynamic> map) {
    return MilletItem(
      id: map['_id'] as String,
      name: map['name'] as String,
      listedBy: map['listedBy'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      price: map['price'] * 1.0,
      quantity: map['quantity'] * 1.0,
      images: List<dynamic>.from((map['images'] as List<dynamic>)),
      listedAt: DateTime.parse(map['listedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MilletItem.fromJson(String source) =>
      MilletItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MilletItem(id: $id, name: $name, listedBy: $listedBy, description: $description,category: $category, price: $price,quantity:$quantity, images: $images, listedAt: $listedAt)';
  }

  @override
  bool operator ==(covariant MilletItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.listedBy == listedBy &&
        other.description == description &&
        other.category == category &&
        other.price == price &&
        other.quantity == quantity &&
        listEquals(other.images, images) &&
        other.listedAt == listedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        listedBy.hashCode ^
        description.hashCode ^
        category.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        images.hashCode ^
        listedAt.hashCode;
  }
}
