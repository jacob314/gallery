// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';

import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

// BEGIN cupertinoSegmentedControlDemo

class CupertinoSegmentedControlDemo extends StatefulWidget {
  const CupertinoSegmentedControlDemo({Key key}) : super(key: key);

  @override
  _CupertinoSegmentedControlDemoState createState() =>
      _CupertinoSegmentedControlDemoState();
}

class _CupertinoSegmentedControlDemoState
    extends State<CupertinoSegmentedControlDemo> with RestorationMixin {
  RestorableInt currentSegment = RestorableInt(0);

  @override
  String get restorationId => 'cupertino_segmented_control';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(currentSegment, 'current_segment');
  }

  void onValueChanged(int newValue) {
    setState(() {
      currentSegment.value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = GalleryLocalizations.of(context);
    const segmentedControlMaxWidth = 500.0;
    final children = <int, Widget>{
      0: Text(localizations.colorsIndigo),
      1: Text(localizations.colorsTeal),
      2: Text(localizations.colorsCyan),
    };

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text(
          localizations.demoCupertinoSegmentedControlTitle,
        ),
      ),
      DefaultTextStyle(
        style: CupertinoTheme.of(context)
            .textTheme
            .textStyle
            .copyWith(fontSize: 13),
        SafeArea(
          ListView(
            const SizedBox(height: 16),
            SizedBox(
              width: segmentedControlMaxWidth,
              CupertinoSegmentedControl<int>(
                children: children,
                onValueChanged: onValueChanged,
                groupValue: currentSegment.value,
              ),
            ),
            SizedBox(
              width: segmentedControlMaxWidth,
              Padding(
                padding: const EdgeInsets.all(16),
                CupertinoSlidingSegmentedControl<int>(
                  children: children,
                  onValueChanged: onValueChanged,
                  groupValue: currentSegment.value,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              height: 300,
              alignment: Alignment.center,
              children[currentSegment.value],
            ),
          ),
        ),
      ),
    );
  }
}

// END
