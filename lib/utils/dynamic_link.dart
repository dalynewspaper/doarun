import 'package:doarun/states/group_states.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

import '../flavors.dart';
import 'auth.dart';

class DynamicLink {
  Future<bool> handleDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    handleLinkData(data);
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      handleLinkData(dynamicLink);
    });
    return true;
  }

  Future<void> handleLinkData(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      final GroupStates groupStates = Get.find();
      await groupStates.readGroup(deepLink.queryParameters["groupName"]);
      if (!groupStates.group.value.accounts
          .contains(authService.auth.currentUser.uid)) {
        groupStates.groupsOwned.add(groupStates.group.value);
        groupStates.group.value.accounts.add(authService.auth.currentUser.uid);
        groupStates.updateGroup();
        Get.snackbar(
            "You have join " + deepLink.queryParameters["groupName"], "");
      } else
        Get.snackbar(
            "You have already joined " + deepLink.queryParameters["groupName"],
            "");
    }
  }

  Future<String> createInvitationLink(String groupName) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: "https://doarun" + F.title + ".page.link",
      link: Uri.parse("https://doarun.page.link/post?groupName=$groupName"),
      androidParameters: AndroidParameters(
        packageName: F.title + ".doarun.app",
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );
    final link = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      link,
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    return shortenedLink.shortUrl.toString();
  }
}

final DynamicLink dynamicLink = DynamicLink();
