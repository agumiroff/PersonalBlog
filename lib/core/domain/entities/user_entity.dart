class UserData {
  final String email;
  final String password;
  final String firstName;
  final String secondName;
  final List<dynamic>? posts;
  final List<dynamic>? bookMarks;

  UserData(this.posts, this.bookMarks, this.firstName, this.secondName, {required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'firstName': firstName,
      'secondName': secondName,
      'posts': posts ?? [],
      'bookmarks': bookMarks ?? [],
    };
  }
}
