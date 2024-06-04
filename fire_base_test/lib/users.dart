import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Users {
  String name;
  int age;
  String email;
  Users({
    required this.name,
    required this.age,
    required this.email,
  });

  @override
  String toString() => 'Users(name: $name, age: $age, email: $email)';

  Users copyWith({
    String? name,
    int? age,
    String? email,
  }) {
    return Users(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'email': email,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      name: map['name'],
      age: map['age'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) =>
      Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age && other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ email.hashCode;
}