class Order {

  Order({
    this.id,
    this.userId,
    this.items,
    this.totalAmount,
    this.status,
    this.shippingAddress,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalAmount: json['total_amount'] as double?,
      status: json['status'] as String?,
      shippingAddress: json['shipping_address'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
  final String? id;
  final String? userId;
  final List<OrderItem>? items;
  final double? totalAmount;
  final String? status;
  final String? shippingAddress;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'items': items?.map((item) => item.toJson()).toList(),
      'total_amount': totalAmount,
      'status': status,
      'shipping_address': shippingAddress,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Order copyWith({
    String? id,
    String? userId,
    List<OrderItem>? items,
    double? totalAmount,
    String? status,
    String? shippingAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class OrderItem {

  OrderItem({
    this.productId,
    this.productName,
    this.quantity,
    this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'] as String?,
      productName: json['product_name'] as String?,
      quantity: json['quantity'] as int?,
      price: json['price'] as double?,
    );
  }
  final String? productId;
  final String? productName;
  final int? quantity;
  final double? price;

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'price': price,
    };
  }
}
