import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/models/base_model.dart';
import 'package:untoggl_project/common/models/team.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';

abstract class GenericFirestoreService<T extends BaseModel> {
  final String collectionName;
  final firestore = FirebaseFirestore.instance;
  final firebase = GetIt.instance<FirebaseService>();

  late final CollectionReference<Map<String, dynamic>> collection;

  GenericFirestoreService({required this.collectionName}) {
    collection = firestore.collection(collectionName);
  }

  Stream<List<T>> get getAll {
    if (firebase.userId.isEmpty) {
      return const Stream.empty();
    }
    return collection
        .snapshots()
        .map((list) => list.docs.map((doc) => fromJson(doc.data())).toList());
  }

  Stream<T?> get getByUser {
    return getByUserId(firebase.userId);
  }

  Stream<T?> getByUserId(String id) {
    if (firebase.userId.isEmpty) {
      return const Stream.empty();
    }
    final ref = collection.where('userId', isEqualTo: id);
    return ref.snapshots().map((list) {
      final data = list.docs.map((doc) => fromJson(doc.data()));
      if (data.isEmpty) {
        return null;
      }
      return data.first;
    });
  }

  Stream<List<T>> getByIdList(String id) {
    if (firebase.userId.isEmpty) {
      return const Stream.empty();
    }
    final ref = collection.where('userId', isEqualTo: id);
    return ref
        .snapshots()
        .map((list) => list.docs.map((doc) => fromJson(doc.data())).toList());
  }

  Stream<T> getById(String id) {
    if (firebase.userId.isEmpty) {
      return const Stream.empty();
    }
    final ref = collection.where('id', isEqualTo: id);
    return ref
        .snapshots()
        .map((list) => list.docs.map((doc) => fromJson(doc.data())).first);
  }

  Future<T> getByIdSync(String id) async {
    if (firebase.userId.isEmpty) {
      return Future.error('User not logged in');
    }
    final ref = await _fetchItem(id);
    if (ref.docs.isEmpty) {
      return Future.error('Item not found');
    }
    return fromJson(ref.docs.first.data());
  }

  Future<T> getByUserIdSync(String id) async {
    if (firebase.userId.isEmpty) {
      return Future.error('User not logged in');
    }
    final ref = await collection.where('userId', isEqualTo: id).get();
    if (ref.docs.isEmpty) {
      return Future.error('Item not found');
    }
    return fromJson(ref.docs.first.data());
  }

  Future<void> create(T item) async {
    if (firebase.userId.isEmpty) {
      return;
    }
    final ref = collection.doc();
    await ref.set(toJson(item));
  }

  Future<void> update(T item) async {
    if (firebase.userId.isEmpty) {
      return;
    }
    final QuerySnapshot<Map<String, dynamic>> ref = await _fetchItem(item.id);
    if (ref.docs.isEmpty) {
      return;
    }
    await ref.docs.first.reference.update(toJson(item));
  }

  Future<void> delete(String id) async {
    if (firebase.userId.isEmpty) {
      return;
    }
    final QuerySnapshot<Map<String, dynamic>> ref = await _fetchItem(id);
    if (ref.docs.isEmpty) {
      return;
    }
    await ref.docs.first.reference.delete();
  }

  Future<void> deleteItem(Team item) async {
    await delete(item.id);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _fetchItem(String id) async {
    final ref = await collection
        .where('id', isEqualTo: id)
        .limit(1) // Should always be 1
        .get();
    return ref;
  }

  T fromJson(Map<String, dynamic> map);

  Map<String, dynamic> toJson(T item) {
    return item.toJson();
  }
}
