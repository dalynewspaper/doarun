import 'package:doarun/utils/database/api.dart';
import 'package:doarun/utils/database/entities/account/entity_account.dart';
import 'package:doarun/utils/database/entities/group/entity_group.dart';
import 'package:get/get.dart';

class GroupStates extends GetxController {
  Rx<EntityGroup> group = EntityGroup().obs;
  EntityGroup groupTmp = EntityGroup();
  List<EntityGroup> groupsOwned = <EntityGroup>[];
  RxList<EntityAccount> groupAccounts = <EntityAccount>[].obs;

  Future<bool> doesGroupExists(String groupName) async {
    return await API.entries.groups.doesExist(groupName);
  }

  Future<void> readAllGroups(String accountId) async {
    groupsOwned.assignAll(await API.entries.groups.readAll(key: accountId));
    if (groupsOwned.isNotEmpty) group.value = groupsOwned.first;
  }

  Future<bool> readAllAccounts() async {
    groupAccounts.clear();
    await Future.forEach(group.value.accounts, (accountUid) async {
      EntityAccount account = await API.entries.accounts.read(accountUid);
      if (!groupAccounts.contains(account)) groupAccounts.add(account);
    });
    return true;
  }

  // CRUD

  Future<void> createGroup(EntityGroup group) async {
    await API.entries.groups.create(group);
    groupsOwned.add(group);
  }

  Future<void> readGroup(String groupId) async {
    group.value = await API.entries.groups.read(groupId);
  }

  Future<void> updateGroup() async {
    await API.entries.groups.update(group.value.name, group.value);
  }

  void deleteGroup(String groupName) {
    API.entries.groups.delete(groupName);
  }
}
