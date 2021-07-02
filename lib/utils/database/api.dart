import 'externs/strava.dart';
import 'services/accounts/service_accounts.dart';
import 'services/groups/service_groups.dart';

class API {
  static final entries = _Entries();
  static final configurations = _Configurations();
  static final extern = _Extern();
}

class _Entries {
  final ServiceAccounts accounts = ServiceAccounts();
  final ServiceGroups groups = ServiceGroups();
}

class _Configurations {}

class _Extern {
  final ServiceStrava strava = ServiceStrava();
}
