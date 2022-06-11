class User {
  late String username;
  late String password;
  late String il;
  late String ilce;
  late String mahalle;
  late String sokak;
  late String acikAdres;

  User(
      {required this.username,
      required this.password,
      required this.il,
      required this.ilce,
      required this.mahalle,
      required this.sokak,
      required this.acikAdres});
  User.empty();
}
