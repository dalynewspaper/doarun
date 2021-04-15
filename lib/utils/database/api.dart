import 'package:doarun/utils/database/services/accounts/service_accounts.dart';

class API {
  static final entries = _Entries();
  static final configurations = _Configurations();
}

class _Entries {
  final ServiceAccounts accounts = ServiceAccounts();
}

class _Configurations {}
