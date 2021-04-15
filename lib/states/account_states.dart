import 'package:doarun/utils/database/api.dart';
import 'package:doarun/utils/database/entities/account/entity_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AccountStates extends GetxController {
  EntityAccount account = EntityAccount();

  Future<bool> doesAccountExists(String accountId) async {
    return await API.entries.accounts.isExist(accountId);
  }

  // CRUD

  Future<void> createAccount() async {
    await API.entries.accounts.create(account);
  }

  Future<void> readAccount(String accountId) async {
    account = await API.entries.accounts.read(accountId);
  }

  Future<void> updateAccount() async {
    await API.entries.accounts.update(account.uid, account);
  }

  void deleteAccount() {
    API.entries.accounts.delete(FirebaseAuth.instance.currentUser.uid);
  }
}
