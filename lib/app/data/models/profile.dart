class Profile {

  Profile({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.dateOfBirth,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zip_code'] as String?,
      country: json['country'] as String?,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      avatar: json['avatar'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
  final String? id;
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? address;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final DateTime? dateOfBirth;
  final String? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'country': country,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'avatar': avatar,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Profile copyWith({
    String? id,
    String? userId,
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    DateTime? dateOfBirth,
    String? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
