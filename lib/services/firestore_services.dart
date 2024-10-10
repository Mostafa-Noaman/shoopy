import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreServices {
  FireStoreServices._();

  static final instance = FireStoreServices._();
  final _fireStore = FirebaseFirestore.instance;

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = _fireStore.doc(path);
    debugPrint('Request: $data');
    await reference.set(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = _fireStore.doc(path);
    await reference.delete();
  }

  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) async {
    final reference = _fireStore.doc(path);
    final snapshot = await reference.get();
    return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

  Stream<T> documentStream<T>(
      {required String path,
      required T Function(Map<String, dynamic>? data, String documentId)
          builder}) {
    final reference = _fireStore.doc(path);
    final snapShots = reference.snapshots();
    return snapShots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query query = _fireStore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = await query.get();
    final result = snapshots.docs
        .map((snapShot) =>
            builder(snapShot.data() as Map<String, dynamic>, snapShot.id))
        .where((value) => value != null)
        .toList();
    if (sort != null) {
      result.sort(sort);
    }
    return result;
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _fireStore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map(
      (snapshot) {
        final result = snapshot.docs
            .map((snapshot) =>
                builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((value) => value != null)
            .toList();
        if (sort != null) {
          result.sort(sort);
        }
        return result;
      },
    );
  }
}
