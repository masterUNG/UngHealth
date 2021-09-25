import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String typeUser;
  final String user;
  final String password;
  final String address;
  final String phone;
  final String lat;
  final String lng;
  final String avatar;
  final String reference;
  final String status;
  UserModel({
    required this.id,
    required this.name,
    required this.typeUser,
    required this.user,
    required this.password,
    required this.address,
    required this.phone,
    required this.lat,
    required this.lng,
    required this.avatar,
    required this.reference,
    required this.status,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? typeUser,
    String? user,
    String? password,
    String? address,
    String? phone,
    String? lat,
    String? lng,
    String? avatar,
    String? reference,
    String? status,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      typeUser: typeUser ?? this.typeUser,
      user: user ?? this.user,
      password: password ?? this.password,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      avatar: avatar ?? this.avatar,
      reference: reference ?? this.reference,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'typeUser': typeUser,
      'user': user,
      'password': password,
      'address': address,
      'phone': phone,
      'lat': lat,
      'lng': lng,
      'avatar': avatar,
      'reference': reference,
      'status': status,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      typeUser: map['typeUser'],
      user: map['user'],
      password: map['password'],
      address: map['address'],
      phone: map['phone'],
      lat: map['lat'],
      lng: map['lng'],
      avatar: map['avatar'],
      reference: map['reference'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, typeUser: $typeUser, user: $user, password: $password, address: $address, phone: $phone, lat: $lat, lng: $lng, avatar: $avatar, reference: $reference, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.name == name &&
      other.typeUser == typeUser &&
      other.user == user &&
      other.password == password &&
      other.address == address &&
      other.phone == phone &&
      other.lat == lat &&
      other.lng == lng &&
      other.avatar == avatar &&
      other.reference == reference &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      typeUser.hashCode ^
      user.hashCode ^
      password.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      avatar.hashCode ^
      reference.hashCode ^
      status.hashCode;
  }
}
