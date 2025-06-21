import 'package:untoggl_project/common/enums/allowed_colors.dart';

import 'base_model.dart';

class Team extends BaseModel {
  final String name;
  final List<String> adminIds;
  final List<String> memberIds;
  final AllowedColors teamColor;

  const Team({
    required String id,
    required this.name,
    required this.adminIds,
    required this.memberIds,
    this.teamColor = AllowedColors.red,
  }) : super(id: id);

  factory Team.fromJson(Map<String, dynamic> data) {
    final adminIds =
        (data['adminIds'] as List<dynamic>).map((e) => e as String).toList();
    final memberIds =
        (data['memberIds'] as List<dynamic>).map((e) => e as String).toList();
    final teamColor = AllowedColors.values.firstWhere(
      (element) => element.color.value == data['teamColor'],
      orElse: () => AllowedColors.red,
    );

    return Team(
      id: data['id'] as String,
      name: data['name'] as String,
      adminIds: adminIds,
      memberIds: memberIds,
      teamColor: teamColor,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'adminIds': adminIds,
      'memberIds': memberIds,
      'teamColor': teamColor.color.value,
    };
  }

  Team copyWith({
    String? id,
    String? name,
    List<String>? adminIds,
    List<String>? memberIds,
    List<String>? taskIds,
    AllowedColors? teamColor,
  }) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      adminIds: adminIds ?? this.adminIds,
      memberIds: memberIds ?? this.memberIds,
      teamColor: teamColor ?? this.teamColor,
    );
  }

  @override
  String toString() {
    return 'Team(id: $id, name: $name, adminIds: $adminIds, memberIds: $memberIds, teamColor: $teamColor)';
  }
}
