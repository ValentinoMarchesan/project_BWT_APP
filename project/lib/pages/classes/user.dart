class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
  });
  User copy({
    String? imagePath,
    String? name,
    String? email,
    String? about,
  }) =>
      // with this method we take a User instance and if there is some modification
      //we'll take the previous state of User
      User(
          imagePath: imagePath ?? this.imagePath,
          name: name ?? this.name,
          email: email ?? this.email,
          about: about ?? this.about);
  //to convert a json to a User object
  //String the key and dynamic the value of the Map
  //convert map json to User object
  static User fromJson(Map<String, dynamic> json) => User(
        imagePath: json['imagePath'],
        name: json['name'],
        email: json['email'],
        about: json['about'],
      );
//to store data in the device
  Map<String, dynamic> toJson() {
    //=>
    return {
      'imagePath': imagePath,
      'name': name,
      'email': email,
      'about': about,
    };
  }
}
