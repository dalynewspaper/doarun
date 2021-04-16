import 'package:doarun/utils/database/api.dart';
import 'package:doarun/utils/database/entities/group/entity_group.dart';
import 'package:get/get.dart';

class GroupStates extends GetxController {
  EntityGroup group = EntityGroup();

  Future<bool> doesGroupExists(String groupName) async {
    return await API.entries.groups.doesExist(groupName);
  }

  // CRUD

  Future<void> createGroup() async {
    await API.entries.groups.create(group);
  }

  Future<void> readGroup(String groupId) async {
    group = await API.entries.groups.read(groupId);
  }

  Future<void> updateGroup() async {
    await API.entries.groups.update(group.name, group);
  }

  void deleteGroup(String groupName) {
    API.entries.groups.delete(groupName);
  }
}
