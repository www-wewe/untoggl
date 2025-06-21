import 'package:untoggl_project/common/models/base_model.dart';

class UserSettings extends BaseModel {
  final bool notifications;
  final bool darkMode;
  final String? photoUrl;

  // This is for easy access to the user's email
  final String email;
  final String userId;

  const UserSettings({
    this.darkMode = false,
    this.notifications = false,
    this.email = '',
    String id = '',
    this.userId = '',
    this.photoUrl = '',
  }) : super(id: id);

  UserSettings copyWith({
    bool? notifications,
    bool? darkMode,
    String? email,
    String? id,
    String? userId,
    String? photoUrl,
  }) {
    return UserSettings(
      notifications: notifications ?? this.notifications,
      darkMode: darkMode ?? this.darkMode,
      email: email ?? this.email,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notifications': notifications,
      'darkMode': darkMode,
      'email': email,
      'userId': userId,
      'photoUrl': photoUrl ?? '',
    };
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      notifications: json['notifications'] as bool,
      darkMode: json['darkMode'] as bool,
      email: json['email'] as String,
      id: json['id'] as String,
      userId: json['userId'] as String,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  @override
  String toString() {
    return 'UserSettings{notifications: $notifications, darkMode: $darkMode, email: $email, id: $id, userId: $userId, photoUrl: $photoUrl}';
  }
}
