class UserData {
  final String avatarLink;
  final String uid;
  final String email;
  final String password;
  final String firstName;
  final String secondName;
  final List<dynamic>? posts;
  final List<dynamic>? bookMarks;

  UserData(
    this.posts,
    this.bookMarks,
    this.firstName,
    this.secondName,
    this.uid,
    this.avatarLink, {
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson(uid) {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'password': password,
      'firstName': firstName,
      'secondName': secondName,
      'posts': posts ?? [],
      'bookmarks': bookMarks ?? [],
    };
  }
}
