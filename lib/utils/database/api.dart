import 'package:doarun/utils/database/services/accounts/service_accounts.dart';
import 'package:doarun/utils/database/services/groups/service_groups.dart';

class API {
  static final entries = _Entries();
  static final configurations = _Configurations();
}

class _Entries {
  final ServiceAccounts accounts = ServiceAccounts();
  final ServiceGroups groups = ServiceGroups();
}

class _Configurations {}
