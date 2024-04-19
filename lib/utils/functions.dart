import 'dart:io';

void platformSpecificAction(
    {required Function() action, bool isMobileSpecific = true}) {
  if (isMobileSpecific) {
    if (Platform.isAndroid || Platform.isIOS) {
      action.call();
    }
  } else {
    action.call();
  }
}
