// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

// BEGIN cupertinoContextMenuDemo

class CupertinoContextMenuDemo extends StatelessWidget {
  const CupertinoContextMenuDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final galleryLocalizations = GalleryLocalizations.of(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text(
          galleryLocalizations.demoCupertinoContextMenuTitle,
        ),
      ),
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
          Center(
             SizedBox(
              width: 100,
              height: 100,
               CupertinoContextMenu(
                actions: [
                  CupertinoContextMenuAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                     Text(
                      galleryLocalizations.demoCupertinoContextMenuActionOne,
                    ),
                  ),
                  CupertinoContextMenuAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                     Text(
                      galleryLocalizations.demoCupertinoContextMenuActionTwo,
                    ),
                  ),
                ],
                 const FlutterLogo(size: 250),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(30),
             Text(
              galleryLocalizations.demoCupertinoContextMenuActionText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          )
        ,
      ),
    );
  }
}

// END
