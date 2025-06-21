import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<bool> get isUserLoggedIn =>
      _firebaseAuth.authStateChanges().map((user) => user != null);

  bool get isUserLoggedInFuture {
    final user = _firebaseAuth.currentUser;
    return user != null && !user.isAnonymous;
  }

  Stream<User?> get user => _firebaseAuth.userChanges();

  String get userId => FirebaseAuth.instance.currentUser?.uid ?? '-1';

  String? get userName => FirebaseAuth.instance.currentUser?.displayName;

  FirebaseService() {
    _init();
  }

  Future<void> _init() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      await _firebaseAuth.signInAnonymously();
    }
    print("FirebaseService initialized");
  }

  Future<void> promoteToUser(String email, String password) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final username = email.split('@').first;
      await FirebaseAuth.instance.currentUser?.updateDisplayName(username);
    }
  }

  Future<void> deleteAnonymousUser() async {
    await FirebaseAuth.instance.currentUser?.delete();
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> updateDisplayName(String displayName) async {
    await FirebaseAuth.instance.currentUser?.updateDisplayName(displayName);
  }

  Future<void> updateEmail(String email) async {
    await FirebaseAuth.instance.currentUser?.updateEmail(email);
  }

  Future<void> updatePassword(String password) async {
    await FirebaseAuth.instance.currentUser?.updatePassword(password);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<String?> signUpWithEmailAndPassword(
    String email,
    String password,
    String validation,
  ) async {
    if (password != validation) {
      throw Exception('Passwords do not match');
    }
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    final username = email.split('@').first;
    await FirebaseAuth.instance.currentUser?.updateDisplayName(username);

    return FirebaseAuth.instance.currentUser?.uid;
  }

  // User getters
  Future<void> sendEmailVerification() async {
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
  }

  Future<void> sendPasswordResetEmail() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: FirebaseAuth.instance.currentUser?.email ?? "",
    );
  }

  Future<void> updateProfilePicture(String url) async {
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
  }
}
