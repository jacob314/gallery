// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:gallery/demos/material/material_demo_types.dart';

// BEGIN gridListsDemo

class GridListDemo extends StatelessWidget {
  const GridListDemo({Key key, this.type}) : super(key: key);

  final GridListDemoType type;

  List<_Photo> _photos(BuildContext context) {
    return [
      _Photo(
        assetName: 'places/india_chennai_flower_market.png',
        title: GalleryLocalizations.of(context).placeChennai,
        subtitle: GalleryLocalizations.of(context).placeFlowerMarket,
      ),
      _Photo(
        assetName: 'places/india_tanjore_bronze_works.png',
        title: GalleryLocalizations.of(context).placeTanjore,
        subtitle: GalleryLocalizations.of(context).placeBronzeWorks,
      ),
      _Photo(
        assetName: 'places/india_tanjore_market_merchant.png',
        title: GalleryLocalizations.of(context).placeTanjore,
        subtitle: GalleryLocalizations.of(context).placeMarket,
      ),
      _Photo(
        assetName: 'places/india_tanjore_thanjavur_temple.png',
        title: GalleryLocalizations.of(context).placeTanjore,
        subtitle: GalleryLocalizations.of(context).placeThanjavurTemple,
      ),
      _Photo(
        assetName: 'places/india_tanjore_thanjavur_temple_carvings.png',
        title: GalleryLocalizations.of(context).placeTanjore,
        subtitle: GalleryLocalizations.of(context).placeThanjavurTemple,
      ),
      _Photo(
        assetName: 'places/india_pondicherry_salt_farm.png',
        title: GalleryLocalizations.of(context).placePondicherry,
        subtitle: GalleryLocalizations.of(context).placeSaltFarm,
      ),
      _Photo(
        assetName: 'places/india_chennai_highway.png',
        title: GalleryLocalizations.of(context).placeChennai,
        subtitle: GalleryLocalizations.of(context).placeScooters,
      ),
      _Photo(
        assetName: 'places/india_chettinad_silk_maker.png',
        title: GalleryLocalizations.of(context).placeChettinad,
        subtitle: GalleryLocalizations.of(context).placeSilkMaker,
      ),
      _Photo(
        assetName: 'places/india_chettinad_produce.png',
        title: GalleryLocalizations.of(context).placeChettinad,
        subtitle: GalleryLocalizations.of(context).placeLunchPrep,
      ),
      _Photo(
        assetName: 'places/india_tanjore_market_technology.png',
        title: GalleryLocalizations.of(context).placeTanjore,
        subtitle: GalleryLocalizations.of(context).placeMarket,
      ),
      _Photo(
        assetName: 'places/india_pondicherry_beach.png',
        title: GalleryLocalizations.of(context).placePondicherry,
        subtitle: GalleryLocalizations.of(context).placeBeach,
      ),
      _Photo(
        assetName: 'places/india_pondicherry_fisherman.png',
        title: GalleryLocalizations.of(context).placePondicherry,
        subtitle: GalleryLocalizations.of(context).placeFisherman,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(GalleryLocalizations.of(context).demoGridListsTitle),
      ),
      body: GridView.count(
        restorationId: 'grid_view_demo_grid_offset',
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1,
        _photos(context).map<Widget>((photo) {
          return _GridDemoPhotoItem(
            photo: photo,
            tileStyle: type,
          );
        }).toList(),
      ),
    );
  }
}

class _Photo {
  _Photo({
    this.assetName,
    this.title,
    this.subtitle,
  });

  final String assetName;
  final String title;
  final String subtitle;
}

/// Allow the text size to shrink to fit in the space
class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      Text(text),
    );
  }
}

class _GridDemoPhotoItem extends StatelessWidget {
  const _GridDemoPhotoItem({
    Key key,
    @required this.photo,
    @required this.tileStyle,
  }) : super(key: key);

  final _Photo photo;
  final GridListDemoType tileStyle;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      Image.asset(
        photo.assetName,
        package: 'flutter_gallery_assets',
        fit: BoxFit.cover,
      ),
    );

    switch (tileStyle) {
      case GridListDemoType.imageOnly:
        return image;
      case GridListDemoType.header:
        return GridTile(
          header: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            GridTileBar(
              title: _GridTitleText(photo.title),
              backgroundColor: Colors.black45,
            ),
          ),
          image,
        );
      case GridListDemoType.footer:
        return GridTile(
          footer: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            GridTileBar(
              backgroundColor: Colors.black45,
              title: _GridTitleText(photo.title),
              subtitle: _GridTitleText(photo.subtitle),
            ),
          ),
          image,
        );
    }
    return null;
  }
}

// END
