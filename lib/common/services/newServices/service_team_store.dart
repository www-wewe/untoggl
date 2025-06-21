import 'package:untoggl_project/common/enums/allowed_colors.dart';
import 'package:untoggl_project/common/models/team.dart';
import 'package:untoggl_project/common/services/generic_firestore_service.dart';

class ServiceTeamStore extends GenericFirestoreService<Team> {
  ServiceTeamStore() : super(collectionName: 'teams');

  @override
  Team fromJson(Map<String, dynamic> map) {
    return Team.fromJson(map);
  }

  Stream<List<Team>> get getUsersTeams {
    final userId = firebase.userId;
    if (userId.isEmpty) {
      return const Stream.empty();
    }
    return collection
        .where('memberIds', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => fromJson(doc.data())).toList();
    });
  }

  Stream<List<Team>> get getWhereUserIsAdmin {
    final userId = firebase.userId;
    if (userId.isEmpty) {
      return const Stream.empty();
    }
    return collection
        .where('adminIds', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => fromJson(doc.data())).toList();
    });
  }

  Stream<List<Team>> get getWhereUserIsMember {
    final userId = firebase.userId;
    if (userId.isEmpty) {
      return const Stream.empty();
    }
    return collection
        .where('memberIds', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final Team team = fromJson(doc.data());
            if (team.adminIds.contains(userId)) {
              return null;
            }
            return team;
          })
          .nonNulls
          .toList();
    });
  }

  @override
  Future<void> create(Team item) async {
    item = item.copyWith(
      adminIds: [firebase.userId],
      memberIds: [firebase.userId],
    );
    await super.create(item);
  }

  Future<void> updateColor(AllowedColors color, String id) async {
    final team = await getByIdSync(id);
    await update(team.copyWith(teamColor: color));
  }

  Future<bool> isUserAdmin(String teamId) async {
    final team = await getByIdSync(teamId);
    return team.adminIds.contains(firebase.userId);
  }

  // Member's management
  Future<void> removeTeamMembers(String teamId, List<String> userIds) async {
    final team = await getByIdSync(teamId);
    final newMembers =
        team.memberIds.where((id) => !userIds.contains(id)).toList();
    await update(team.copyWith(memberIds: newMembers));
  }

  // Admin's management
  Future<void> promoteToAdmin(String teamId, List<String> userIds) async {
    final team = await getByIdSync(teamId);
    final newAdmins = team.adminIds + userIds;
    await update(team.copyWith(adminIds: newAdmins));
  }

  Future<void> removeAdmin(String teamId, List<String> userIds) async {
    final team = await getByIdSync(teamId);
    final newAdmins =
        team.adminIds.where((id) => !userIds.contains(id)).toList();
    await update(team.copyWith(adminIds: newAdmins));
  }
}
