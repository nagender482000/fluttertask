class User {
  String name;
  int age;
  String city;

  User(this.name, this.age, this.city);

  @override
  toString() {
    return ('$name - $age - $city \n');
  }

}



