import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doarun/utils/database/entities/group/entity_group.dart';

import '../../config.dart';
import '../i_service.dart';

class ServiceGroups extends IService<EntityGroup> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(endpointGroups);

  @override
  Future<void> create(EntityGroup entity, {String key = ""}) async {
    await _collectionReference.doc(entity.name).set(entity.toMap());
  }

  @override
  Future<void> delete(String uid, {String key = ""}) async {
    await _collectionReference.doc(uid).delete();
  }

  @override
  Future<EntityGroup> read(String uid, {String key = ""}) async {
    final DocumentSnapshot snap = await _collectionReference.doc(uid).get();
    if (snap != null) return EntityGroup.fromJson(snap.data(), key: snap.id);
    return null;
  }

  @override
  Future<List<EntityGroup>> readAll({String key = ""}) async {
    QuerySnapshot snap = await _collectionReference.get();

    List<EntityGroup> entities = <EntityGroup>[];
    snap.docs.forEach((element) {
      entities.add(EntityGroup.fromJson(element.data(), key: element.id));
    });
    return entities;
  }

  @override
  Future<void> update(String uid, EntityGroup entityGroup,
      {String key = ""}) async {
    await _collectionReference.doc(uid).update(entityGroup.toMap());
  }

  Future<bool> doesExist(String uid) async {
    final DocumentSnapshot snap = await _collectionReference.doc(uid).get();
    if (snap.data() == null) return false;
    return true;
  }
}
