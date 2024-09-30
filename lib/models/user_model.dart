class UserModel {
  final String uId;
  final String email;

  UserModel({required this.uId, required this.email});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'uId': uId});
    result.addAll({'email': email});
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      uId: documentId,
      email: map['email'],
    );
  }
}
