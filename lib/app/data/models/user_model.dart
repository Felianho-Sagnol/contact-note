class UserModel {
  final String fullName;
  final String email;
  final String phone ;
  final String imageUrl ;
  final String uid ;
  final String aboutMe ;

  UserModel({
    this.fullName = "",
    this.email = "",
    this.phone = "",
    this.uid = "",
    this.imageUrl ="",
    this.aboutMe = "",
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      phone: map['phone'],
      imageUrl: map['imageUrl'],
      aboutMe : map['aboutMe']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'imageUrl' : imageUrl,
      'aboutMe': aboutMe,
    };
  }
}
