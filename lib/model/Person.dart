class Person {
  late String email;
  late String password;
  late String il;
  late String ilce;

  Person(this.email, this.password, this.il, this.ilce);

  factory Person.fromJson(Map<dynamic, dynamic> json) {
    return Person(json["email"] as String, json["password"] as String,
        json["il"] as String, json["ilce"] as String);
  }
}
