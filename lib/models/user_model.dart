class UserModel {
  late int id;
  late String name;
  late String address;
  late String phone;
  late String username;
  late String profilePhotoUrl;
  late String roles;
  late String token;

  UserModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.username,
    required this.profilePhotoUrl,
    required this.roles,
    required this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    username = json['username'];
    profilePhotoUrl = json['profile_photo_url'];
    roles = json['roles'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'username': username,
      'profile_photo_url': profilePhotoUrl,
      'roles': roles,
      'token': token,
    };
  }
}
