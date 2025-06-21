import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untoggl_project/common/models/base_model.dart';
import 'package:untoggl_project/common/models/team.dart';

class Task extends BaseModel {
  final String name;
  final String description;
  final bool completed;
  final DateTime startsAt;
  final DateTime endsAt;
  final DateTime? completedAt;
  final String userId;
  final Team? assignedTeam;

  const Task({
    required String id,
    required this.name,
    required this.description,
    required this.completed,
    required this.startsAt,
    required this.endsAt,
    this.completedAt,
    this.assignedTeam,
    this.userId = '',
  }) : super(id: id);

  Task copyWith({
    String? id,
    String? name,
    String? description,
    bool? completed,
    DateTime? startsAt,
    DateTime? endsAt,
    String? userId,
    DateTime? completedAt,
    Team? assignedTeam,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      completedAt: completedAt ?? this.completedAt,
      assignedTeam: assignedTeam ?? this.assignedTeam,
      userId: userId ?? this.userId,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    final starts = json['startsAt'] as Timestamp;
    final ends = json['endsAt'] as Timestamp;
    final completed = json['completedAt'] as Timestamp?;
    final assignedTo = json['assignedTo'] != null
        ? Team.fromJson(json['assignedTo'] as Map<String, dynamic>)
        : null;

    return Task(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      completed: json['completed'] as bool,
      startsAt: starts.toDate(),
      userId: json['userId'] as String,
      endsAt: ends.toDate(),
      completedAt: completed?.toDate(),
      assignedTeam: assignedTo,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'completed': completed,
      'startsAt': startsAt,
      'endsAt': endsAt,
      'completedAt': completedAt,
      'assignedTo': assignedTeam?.id,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return 'Task(id: $id, name: $name, description: $description, completed: $completed, startsAt: $startsAt, endsAt: $endsAt, completedAt: $completedAt, assignedTo: $assignedTeam, userId: $userId)';
  }
}
