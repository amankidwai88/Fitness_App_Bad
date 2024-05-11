class FirebaseUser {
  String id;
  String Name;
  String Weight;
  String Height;

  FirebaseUser({
    required this.id,
    required this.Name,
    required this.Weight,
    required this.Height,
  });

  FirebaseUser copyWith({
    String? id,
    String? Name,
    String? Weight,
    String? Height,
  }) {
    return FirebaseUser(
      id: id ?? this.id,
      Name: Name ?? this.Name,
      Weight: Weight ?? this.Weight,
      Height: Height ?? this.Height,
    );
  }

  Map<String, Object> toMap() {
    return {
      'id': id,
      'Name': Name,
      'completed': Weight,
      'price': Height,
    };
  }
}