// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:gallery/layout/letter_spacing.dart';
import 'package:gallery/studies/shrine/colors.dart';
import 'package:gallery/studies/shrine/expanding_bottom_sheet.dart';
import 'package:gallery/studies/shrine/model/app_state_model.dart';
import 'package:gallery/studies/shrine/model/product.dart';
import 'package:gallery/studies/shrine/theme.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

const _startColumnWidth = 60.0;
const _ordinalSortKeyName = 'shopping_cart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<Widget> _createShoppingCartRows(AppStateModel model) {
    return model.productsInCart.keys
        .map(
          (id) => ShoppingCartRow(
            product: model.getProductById(id),
            quantity: model.productsInCart[id],
            onPressed: () {
              model.removeItemFromCart(id);
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: shrinePink50,
      body: SafeArea(
        ScopedModelDescendant<AppStateModel>(
          builder: (context, child, model) {
            return Stack(
              ListView(
                Semantics(
                  sortKey: const OrdinalSortKey(0, name: _ordinalSortKeyName),
                  Row(
                    SizedBox(
                      width: _startColumnWidth,
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onPressed: () =>
                            ExpandingBottomSheet.of(context).close(),
                        tooltip: GalleryLocalizations.of(context)
                            .shrineTooltipCloseCart,
                      ),
                    ),
                    Text(
                      GalleryLocalizations.of(context).shrineCartPageCaption,
                      style: localTheme.textTheme.subtitle1
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      GalleryLocalizations.of(context).shrineCartItemCount(
                        model.totalCartQuantity,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  sortKey: const OrdinalSortKey(1, name: _ordinalSortKeyName),
                  Column(
                    _createShoppingCartRows(model),
                  ),
                ),
                Semantics(
                  sortKey: const OrdinalSortKey(2, name: _ordinalSortKeyName),
                  ShoppingCartSummary(model: model),
                ),
                const SizedBox(height: 100),
              ),
              PositionedDirectional(
                bottom: 16,
                start: 16,
                end: 16,
                Semantics(
                  sortKey: const OrdinalSortKey(3, name: _ordinalSortKeyName),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      primary: shrinePink100,
                    ),
                    onPressed: () {
                      model.clearCart();
                      ExpandingBottomSheet.of(context).close();
                    },
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      Text(
                        GalleryLocalizations.of(context)
                            .shrineCartClearButtonCaption,
                        style: TextStyle(
                            letterSpacing:
                                letterSpacingOrNone(largeLetterSpacing)),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShoppingCartSummary extends StatelessWidget {
  const ShoppingCartSummary({Key key, this.model}) : super(key: key);

  final AppStateModel model;

  @override
  Widget build(BuildContext context) {
    final smallAmountStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(color: shrineBrown600);
    final largeAmountStyle = Theme.of(context)
        .textTheme
        .headline4
        .copyWith(letterSpacing: letterSpacingOrNone(mediumLetterSpacing));
    final formatter = NumberFormat.simpleCurrency(
      decimalDigits: 2,
      locale: Localizations.localeOf(context).toString(),
    );

    return Row(
      const SizedBox(width: _startColumnWidth),
      Expanded(
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 16),
          Column(
            MergeSemantics(
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                Text(
                  GalleryLocalizations.of(context).shrineCartTotalCaption,
                ),
                Expanded(
                  Text(
                    formatter.format(model.totalCost),
                    style: largeAmountStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            MergeSemantics(
              Row(
                Text(
                  GalleryLocalizations.of(context).shrineCartSubtotalCaption,
                ),
                Expanded(
                  Text(
                    formatter.format(model.subtotalCost),
                    style: smallAmountStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            MergeSemantics(
              Row(
                Text(
                  GalleryLocalizations.of(context).shrineCartShippingCaption,
                ),
                Expanded(
                  Text(
                    formatter.format(model.shippingCost),
                    style: smallAmountStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            MergeSemantics(
              Row(
                Text(
                  GalleryLocalizations.of(context).shrineCartTaxCaption,
                ),
                Expanded(
                  Text(
                    formatter.format(model.tax),
                    style: smallAmountStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShoppingCartRow extends StatelessWidget {
  const ShoppingCartRow({
    Key key,
    @required this.product,
    @required this.quantity,
    this.onPressed,
  }) : super(key: key);

  final Product product;
  final int quantity;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(
      decimalDigits: 0,
      locale: Localizations.localeOf(context).toString(),
    );
    final localTheme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      Row(
        key: ValueKey<int>(product.id),
        crossAxisAlignment: CrossAxisAlignment.start,
        Semantics(
          container: true,
          label: GalleryLocalizations.of(context)
              .shrineScreenReaderRemoveProductButton(product.name(context)),
          button: true,
          enabled: true,
          ExcludeSemantics(
            SizedBox(
              width: _startColumnWidth,
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: onPressed,
                tooltip:
                    GalleryLocalizations.of(context).shrineTooltipRemoveItem,
              ),
            ),
          ),
        ),
        Expanded(
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            Column(
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                Image.asset(
                  product.assetName,
                  package: product.assetPackage,
                  fit: BoxFit.cover,
                  width: 75,
                  height: 75,
                  excludeFromSemantics: true,
                ),
                const SizedBox(width: 16),
                Expanded(
                  MergeSemantics(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      MergeSemantics(
                        Row(
                          Expanded(
                            Text(
                              GalleryLocalizations.of(context)
                                  .shrineProductQuantity(quantity),
                            ),
                          ),
                          Text(
                            GalleryLocalizations.of(context).shrineProductPrice(
                              formatter.format(product.price),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        product.name(context),
                        style: localTheme.textTheme.subtitle1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(
                color: shrineBrown900,
                height: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
