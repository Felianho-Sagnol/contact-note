class UserModel {
  final String fullName;
  final String email;
  final String phone ;
  final String imageUrle ;
  final String uid ;
  final String? aboutMe ;

  UserModel({
    this.fullName = "",
    this.email = "",
    this.phone = "",
    this.uid = "",
    this.imageUrle ="",
    this.aboutMe = "",
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      phone: map['phone'],
      imageUrle: map['imageUrle'],
      aboutMe : map['aboutMe']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'imageUrle' : imageUrle,
      'aboutMe': aboutMe,
    };
  }
}
