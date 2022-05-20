// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';

import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:gallery/data/gallery_options.dart';
import 'package:gallery/demos/cupertino/demo_types.dart';

// BEGIN cupertinoAlertDemo

class CupertinoAlertDemo extends StatefulWidget {
  const CupertinoAlertDemo({
    Key key,
    @required this.type,
  }) : super(key: key);

  final AlertDemoType type;

  @override
  _CupertinoAlertDemoState createState() => _CupertinoAlertDemoState();
}

class _CupertinoAlertDemoState extends State<CupertinoAlertDemo>
    with RestorationMixin {
  RestorableStringN lastSelectedValue = RestorableStringN(null);
  RestorableRouteFuture<String> _alertDialogRoute;
  RestorableRouteFuture<String> _alertWithTitleDialogRoute;
  RestorableRouteFuture<String> _alertWithButtonsDialogRoute;
  RestorableRouteFuture<String> _alertWithButtonsOnlyDialogRoute;
  RestorableRouteFuture<String> _modalPopupRoute;

  @override
  String get restorationId => 'cupertino_alert_demo';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(
      lastSelectedValue,
      'last_selected_value',
    );
    registerForRestoration(
      _alertDialogRoute,
      'alert_demo_dialog_route',
    );
    registerForRestoration(
      _alertWithTitleDialogRoute,
      'alert_with_title_press_demo_dialog_route',
    );
    registerForRestoration(
      _alertWithButtonsDialogRoute,
      'alert_with_title_press_demo_dialog_route',
    );
    registerForRestoration(
      _alertWithButtonsOnlyDialogRoute,
      'alert_with_title_press_demo_dialog_route',
    );
    registerForRestoration(
      _modalPopupRoute,
      'modal_popup_route',
    );
  }

  void _setSelectedValue(String value) {
    if (value != null) {
      setState(() {
        lastSelectedValue.value = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _alertDialogRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_alertDemoDialog);
      },
      onComplete: _setSelectedValue,
    );
    _alertWithTitleDialogRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_alertWithTitleDialog);
      },
      onComplete: _setSelectedValue,
    );
    _alertWithButtonsDialogRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_alertWithButtonsDialog);
      },
      onComplete: _setSelectedValue,
    );
    _alertWithButtonsOnlyDialogRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_alertWithButtonsOnlyDialog);
      },
      onComplete: _setSelectedValue,
    );
    _modalPopupRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_modalRoute);
      },
      onComplete: _setSelectedValue,
    );
  }

  String _title(BuildContext context) {
    switch (widget.type) {
      case AlertDemoType.alert:
        return GalleryLocalizations.of(context).demoCupertinoAlertTitle;
      case AlertDemoType.alertTitle:
        return GalleryLocalizations.of(context)
            .demoCupertinoAlertWithTitleTitle;
      case AlertDemoType.alertButtons:
        return GalleryLocalizations.of(context).demoCupertinoAlertButtonsTitle;
      case AlertDemoType.alertButtonsOnly:
        return GalleryLocalizations.of(context)
            .demoCupertinoAlertButtonsOnlyTitle;
      case AlertDemoType.actionSheet:
        return GalleryLocalizations.of(context).demoCupertinoActionSheetTitle;
    }
    return '';
  }

  static Route<String> _alertDemoDialog(
    BuildContext context,
    Object arguments,
  ) {
    return CupertinoDialogRoute<String>(
      context: context,
      builder: (context) => ApplyTextOptions(
        CupertinoAlertDialog(
          title: Text(GalleryLocalizations.of(context).dialogDiscardTitle),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(
                  context,
                ).pop(GalleryLocalizations.of(context).cupertinoAlertDiscard);
              },
              Text(
                GalleryLocalizations.of(context).cupertinoAlertDiscard,
              ),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.of(
                context,
              ).pop(
                GalleryLocalizations.of(context).cupertinoAlertCancel,
              ),
              Text(
                GalleryLocalizations.of(context).cupertinoAlertCancel,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Route<String> _alertWithTitleDialog(
    BuildContext context,
    Object arguments,
  ) {
    return CupertinoDialogRoute<String>(
      context: context,
      builder: (context) => ApplyTextOptions(
        CupertinoAlertDialog(
          title: Text(
            GalleryLocalizations.of(context).cupertinoAlertLocationTitle,
          ),
          content: Text(
            GalleryLocalizations.of(context).cupertinoAlertLocationDescription,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(
                context,
              ).pop(
                GalleryLocalizations.of(context).cupertinoAlertDontAllow,
              ),
              Text(
                GalleryLocalizations.of(context).cupertinoAlertDontAllow,
              ),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.of(
                context,
              ).pop(
                GalleryLocalizations.of(context).cupertinoAlertAllow,
              ),
              Text(
                GalleryLocalizations.of(context).cupertinoAlertAllow,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Route<String> _alertWithButtonsDialog(
    BuildContext context,
    Object arguments,
  ) {
    return CupertinoDialogRoute<String>(
      context: context,
      builder: (context) => ApplyTextOptions(
        CupertinoDessertDialog(
          title: Text(
            GalleryLocalizations.of(context).cupertinoAlertFavoriteDessert,
          ),
          content: Text(
            GalleryLocalizations.of(context).cupertinoAlertDessertDescription,
          ),
        ),
      ),
    );
  }

  static Route<String> _alertWithButtonsOnlyDialog(
    BuildContext context,
    Object arguments,
  ) {
    return CupertinoDialogRoute<String>(
      context: context,
      builder: (context) => const ApplyTextOptions(
        CupertinoDessertDialog(),
      ),
    );
  }

  static Route<String> _modalRoute(
    BuildContext context,
    Object arguments,
  ) {
    return CupertinoModalPopupRoute<String>(
      builder: (context) => ApplyTextOptions(
        CupertinoActionSheet(
          title: Text(
            GalleryLocalizations.of(context).cupertinoAlertFavoriteDessert,
          ),
          message: Text(
            GalleryLocalizations.of(context).cupertinoAlertDessertDescription,
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(
                context,
              ).pop(
                GalleryLocalizations.of(context).cupertinoAlertCheesecake,
              ),
              Text(
                GalleryLocalizations.of(context).cupertinoAlertCheesecake,
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(
                context,
              ).pop(
                GalleryLocalizations.of(context).cupertinoAlertTiramisu,
              ),
              Text(
                GalleryLocalizations.of(context).cupertinoAlertTiramisu,
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(
                context,
              ).pop(
                GalleryLocalizations.of(context).cupertinoAlertApplePie,
              ),
              Text(
                GalleryLocalizations.of(context).cupertinoAlertApplePie,
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(
              context,
            ).pop(
              GalleryLocalizations.of(context).cupertinoAlertCancel,
            ),
            Text(
              GalleryLocalizations.of(context).cupertinoAlertCancel,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text(_title(context)),
      ),
      Builder(
        builder: (context) {
          return Column(
            [
              Expanded(
                Center(
                  CupertinoButton.filled(
                    onPressed: () {
                      switch (widget.type) {
                        case AlertDemoType.alert:
                          _alertDialogRoute.present();
                          break;
                        case AlertDemoType.alertTitle:
                          _alertWithTitleDialogRoute.present();
                          break;
                        case AlertDemoType.alertButtons:
                          _alertWithButtonsDialogRoute.present();
                          break;
                        case AlertDemoType.alertButtonsOnly:
                          _alertWithButtonsOnlyDialogRoute.present();
                          break;
                        case AlertDemoType.actionSheet:
                          _modalPopupRoute.present();
                          break;
                      }
                    },
                    Text(
                      GalleryLocalizations.of(context).cupertinoShowAlert,
                    ),
                  ),
                ),
              ),
              if (lastSelectedValue.value != null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  Text(
                    GalleryLocalizations.of(context)
                        .dialogSelectedOption(lastSelectedValue.value),
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class CupertinoDessertDialog extends StatelessWidget {
  const CupertinoDessertDialog({
    Key key,
    this.title,
    this.content,
  }) : super(key: key);

  final Widget title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(
              context,
            ).pop(
              GalleryLocalizations.of(context).cupertinoAlertCheesecake,
            );
          },
          Text(
            GalleryLocalizations.of(context).cupertinoAlertCheesecake,
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(
              context,
            ).pop(
              GalleryLocalizations.of(context).cupertinoAlertTiramisu,
            );
          },
          Text(
            GalleryLocalizations.of(context).cupertinoAlertTiramisu,
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(
              context,
            ).pop(
              GalleryLocalizations.of(context).cupertinoAlertApplePie,
            );
          },
          Text(
            GalleryLocalizations.of(context).cupertinoAlertApplePie,
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(
              context,
            ).pop(
              GalleryLocalizations.of(context).cupertinoAlertChocolateBrownie,
            );
          },
          Text(
            GalleryLocalizations.of(context).cupertinoAlertChocolateBrownie,
          ),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(
              context,
            ).pop(
              GalleryLocalizations.of(context).cupertinoAlertCancel,
            );
          },
          Text(
            GalleryLocalizations.of(context).cupertinoAlertCancel,
          ),
        ),
      ],
    );
  }
}

// END
