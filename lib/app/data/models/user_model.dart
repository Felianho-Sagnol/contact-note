class UserModel {
  final String fullName;
  final String email;
  final String phone ;
  final String imageUrle ;
  final String uid ;
  UserModel({
    this.fullName = "",
    this.email = "",
    this.phone = "",
    this.uid = "",
    this.imageUrle ="",
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      phone: map['phone'],
      imageUrle: map['imageUrle'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'imageUrle' : imageUrle,
    };
  }
}
