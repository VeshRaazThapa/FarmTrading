// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MilletOrder {
  final String id;
  final String listedBy;
  final bool isDelivered;
  final String farmerId;
  final String phoneFarmer;
  final String phoneCustomer;
  final double price;
  final double quantity;
  final String quantityType;
  final DateTime listedAt;
  final String item;

  MilletOrder({
    required this.id,
    required this.listedBy,
    required this.isDelivered,
    required this.farmerId,
    required this.price,
    required this.phoneFarmer,
    required this.phoneCustomer,
    required this.quantity,
    required this.quantityType,
    required this.listedAt,
    required this.item,
  });

  MilletOrder copyWith({
    String? id,
    String? listedBy,
    bool? isDelivered,
    String? farmerId,
    String? phoneFarmer,
    String? phoneCustomer,
    double? price,
    double? quantity,
    String? quantityType,
    DateTime? listedAt,
    String? item,
  }) {
    return MilletOrder(
      id: id ?? this.id,
      listedBy: listedBy ?? this.listedBy,
      isDelivered: isDelivered ?? this.isDelivered,
      farmerId: farmerId ?? this.farmerId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      quantityType: quantityType ?? this.quantityType,
      listedAt: listedAt ?? this.listedAt,
      phoneFarmer:phoneFarmer ?? this.phoneFarmer,
      phoneCustomer:phoneFarmer ?? this.phoneCustomer,
      item: item ?? this.item,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'listedBy': listedBy,
      'isDelivered': isDelivered,
      'farmerId': farmerId,
      'phoneFarmer':phoneFarmer,
      'phoneCustomer':phoneCustomer,
      'price': price,
      'quantity': quantity,
      'quantityType': quantityType,
      'listedAt': listedAt.toIso8601String(),
      'item': item,
    };
  }

  factory MilletOrder.fromMap(Map<String, dynamic> map) {
    return MilletOrder(
      id: map['_id'] as String,
      isDelivered:map['isDelivered'] as bool,
      listedBy: map['listedBy'] as String,
      farmerId: map['farmerId']  as String,
      price: map['price'] * 1.0,
      quantity: map['quantity'] * 1.0,
      quantityType: map['quantityType'],
      listedAt: DateTime.parse(map['listedAt']),
      item: map['item'], phoneFarmer: map['phoneFarmer'], phoneCustomer: map['phoneCustomer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MilletOrder.fromJson(String source) =>
      MilletOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MilletItemOrder(id: $id, listedBy: $listedBy,isDelivered:$isDelivered,farmerId:$farmerId, price: $price,quantity:$quantity, listedAt: $listedAt, item: $item)';
  }

  @override
  bool operator ==(covariant MilletOrder other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.listedBy == listedBy &&
        other.isDelivered == isDelivered &&
        other.farmerId == farmerId &&
        other.price == price &&
        other.quantity == quantity &&
        other.quantityType == quantityType &&
        other.item == item &&
        other.listedAt == listedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    listedBy.hashCode ^
    isDelivered.hashCode ^
    farmerId.hashCode ^
    price.hashCode ^
    quantity.hashCode ^
    quantityType.hashCode ^
    item.hashCode ^
    listedAt.hashCode;
  }
}