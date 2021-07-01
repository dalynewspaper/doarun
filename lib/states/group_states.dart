import 'package:doarun/utils/database/api.dart';
import 'package:doarun/utils/database/entities/account/entity_account.dart';
import 'package:doarun/utils/database/entities/group/entity_group.dart';
import 'package:get/get.dart';

class GroupStates extends GetxController {
  Rx<EntityGroup> group = EntityGroup().obs;
  List<EntityGroup> groupsOwned = <EntityGroup>[];
  RxList<EntityAccount> groupAccounts = <EntityAccount>[].obs;

  Future<bool> doesGroupExists(String groupName) async {
    return await API.entries.groups.doesExist(groupName);
  }

  Future<void> readAllGroups(String accountId) async {
    groupsOwned.assignAll(await API.entries.groups.readAll(key: accountId));
    group.value = groupsOwned.first;
  }

  Future<bool> readAllAccounts() async {
    groupAccounts.clear();
    await Future.forEach(group.value.accounts, (accountUid) async {
      groupAccounts.add(await API.entries.accounts.read(accountUid));
    });
    return true;
  }

  Future<void> updateLatestRun(String accessToken, String name) async {
    final Map response = await API.extern.strava
        .getAthleteLastActivity(group.value.lastRunTimestamp, accessToken);
    if (response.isNotEmpty) {
      group.value.lastRunTimestamp =
          DateTime.parse(response["start_date_local"]).millisecondsSinceEpoch;
      group.value.lastRunner = name;
      group.value.lastRunPolyline = response["map"]["summary_polyline"];
      group.value.lastRunDistance = response["distance"];
      updateGroup();
    }
  }

  // CRUD

  Future<void> createGroup() async {
    await API.entries.groups.create(group.value);
    groupsOwned.add(group.value);
  }

  Future<void> readGroup(String groupId) async {
    group.value = await API.entries.groups.read(groupId);
  }

  Future<void> updateGroup() async {
    await API.entries.groups.update(group.value.name.value, group.value);
  }

  void deleteGroup(String groupName) {
    API.entries.groups.delete(groupName);
  }
}
