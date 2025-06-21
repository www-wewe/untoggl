/*
  This model is needed for the generics in the Firestore service.
  All other models will extend this one.
 */
class BaseModel {
  final String id;

  const BaseModel({
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
