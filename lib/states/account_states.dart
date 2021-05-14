import 'package:doarun/utils/database/api.dart';
import 'package:doarun/utils/database/entities/account/entity_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AccountStates extends GetxController {
  EntityAccount account = EntityAccount();

  Future<bool> doesAccountExists(String accountId) async {
    return await API.entries.accounts.isExist(accountId);
  }

  Future<bool> getNewTotalDistance() async {
    final Map refreshTokenResponse =
        await API.extern.strava.getAccessToken(account.refreshToken);
    account.refreshToken = refreshTokenResponse["refresh_token"];
    final Map athleteStatsResponse = await API.extern.strava.getAthleteStats(
        account.stravaId, refreshTokenResponse["access_token"]);
    print(athleteStatsResponse);
    account.totalDistance =
        athleteStatsResponse["recent_run_totals"]["distance"] / 1000;
    await updateAccount();
    return true;
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

const ID_ONBOARDING_STEP_AUTH = 0;
const ID_ONBOARDING_STEP_GROUP_CREATION = 1;
const ID_ONBOARDING_STEP_STRAVA = 2;
