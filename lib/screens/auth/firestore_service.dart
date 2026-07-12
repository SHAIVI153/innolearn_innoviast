import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Handles all data upload/download to Cloud Firestore.
/// Replaces the local-only `shared_preferences` storage mentioned in the
/// README with real cloud storage, keyed by the logged-in user's UID.
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  /// ---------- 1) Save/Upload the user profile (called right after sign up) ----------
  Future<void> createUserProfile({
    required String name,
    required String email,
  }) async {
    if (_uid == null) return;
    await _db.collection('users').doc(_uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// ---------- 2) Upload / update lesson completion progress ----------
  /// Example call:
  /// firestoreService.markLessonComplete(courseId: 'c1', lessonId: 'l3');
  Future<void> markLessonComplete({
    required String courseId,
    required String lessonId,
  }) async {
    if (_uid == null) return;
    await _db
        .collection('users')
        .doc(_uid)
        .collection('progress')
        .doc(courseId)
        .set({
      'completedLessons': FieldValue.arrayUnion([lessonId]),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  /// ---------- 3) Upload a quiz score ----------
  Future<void> uploadQuizScore({
    required String courseId,
    required int score,
    required int totalQuestions,
  }) async {
    if (_uid == null) return;
    await _db
        .collection('users')
        .doc(_uid)
        .collection('quizResults')
        .add({
      'courseId': courseId,
      'score': score,
      'totalQuestions': totalQuestions,
      'takenAt': FieldValue.serverTimestamp(),
    });
  }

  /// ---------- 4) Read back progress for the Progress Profile screen ----------
  Stream<QuerySnapshot<Map<String, dynamic>>> watchProgress() {
    return _db
        .collection('users')
        .doc(_uid)
        .collection('progress')
        .snapshots();
  }

  /// ---------- 5) Read the user's profile info ----------
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile() {
    return _db.collection('users').doc(_uid).get();
  }
}