class User {
  int? id;
  String? name;
  String? email;
  int? age;
  int? date = DateTime.now().millisecondsSinceEpoch;

  User({this.name, this.email, this.age});
  User.withId({this.id, this.name, this.email, this.age, this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'age': this.age,
      'date': this.date,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User.withId(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      age: map['age'] as int,
      date: map['date'] as int,
    );
  }
}