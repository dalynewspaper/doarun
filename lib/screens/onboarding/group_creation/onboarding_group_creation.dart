import 'package:doarun/widgets_common/group_creation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingGroupCreation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GroupCreation(isOnboarding: true);
  }
}
