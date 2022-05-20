// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

import 'package:gallery/data/gallery_options.dart';
import 'package:gallery/layout/adaptive.dart';
import 'package:gallery/layout/text_scale.dart';
import 'package:gallery/studies/rally/colors.dart';
import 'package:gallery/studies/rally/data.dart';
import 'package:gallery/studies/rally/finance.dart';
import 'package:gallery/studies/rally/formatters.dart';

/// A page that shows a status overview.
class OverviewView extends StatefulWidget {
  const OverviewView({Key key}) : super(key: key);

  @override
  _OverviewViewState createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  @override
  Widget build(BuildContext context) {
    final alerts = DummyDataService.getAlerts(context);

    if (isDisplayDesktop(context)) {
      const sortKeyName = 'Overview';
      return SingleChildScrollView(
        restorationId: 'overview_scroll_view',
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            Flexible(
              flex: 7,
              Semantics(
                sortKey: const OrdinalSortKey(1, name: sortKeyName),
                const _OverviewGrid(spacing: 24),
              ),
            ),
            const SizedBox(width: 24),
            Flexible(
              flex: 3,
              SizedBox(
                width: 400,
                Semantics(
                  sortKey: const OrdinalSortKey(2, name: sortKeyName),
                  FocusTraversalGroup(
                    _AlertsView(alerts: alerts),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        restorationId: 'overview_scroll_view',
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          Column(
            _AlertsView(alerts: alerts.sublist(0, 1)),
            const SizedBox(height: 12),
            const _OverviewGrid(spacing: 12),
          ),
        ),
      );
    }
  }
}

class _OverviewGrid extends StatelessWidget {
  const _OverviewGrid({Key key, @required this.spacing}) : super(key: key);

  final double spacing;

  @override
  Widget build(BuildContext context) {
    final accountDataList = DummyDataService.getAccountDataList(context);
    final billDataList = DummyDataService.getBillDataList(context);
    final budgetDataList = DummyDataService.getBudgetDataList(context);

    return LayoutBuilder(builder: (context, constraints) {
      final textScaleFactor =
          GalleryOptions.of(context).textScaleFactor(context);

      // Only display multiple columns when the constraints allow it and we
      // have a regular text scale factor.
      const minWidthForTwoColumns = 600;
      final hasMultipleColumns = isDisplayDesktop(context) &&
          constraints.maxWidth > minWidthForTwoColumns &&
          textScaleFactor <= 2;
      final boxWidth = hasMultipleColumns
          ? constraints.maxWidth / 2 - spacing / 2
          : double.infinity;

      return Wrap(
        runSpacing: spacing,
        [
          SizedBox(
            width: boxWidth,
            _FinancialView(
              title: GalleryLocalizations.of(context).rallyAccounts,
              total: sumAccountDataPrimaryAmount(accountDataList),
              financialItemViews:
                  buildAccountDataListViews(accountDataList, context),
              buttonSemanticsLabel:
                  GalleryLocalizations.of(context).rallySeeAllAccounts,
              order: 1,
            ),
          ),
          if (hasMultipleColumns) SizedBox(width: spacing),
          SizedBox(
            width: boxWidth,
            _FinancialView(
              title: GalleryLocalizations.of(context).rallyBills,
              total: sumBillDataPrimaryAmount(billDataList),
              financialItemViews: buildBillDataListViews(billDataList, context),
              buttonSemanticsLabel:
                  GalleryLocalizations.of(context).rallySeeAllBills,
              order: 2,
            ),
          ),
          _FinancialView(
            title: GalleryLocalizations.of(context).rallyBudgets,
            total: sumBudgetDataPrimaryAmount(budgetDataList),
            financialItemViews:
                buildBudgetDataListViews(budgetDataList, context),
            buttonSemanticsLabel:
                GalleryLocalizations.of(context).rallySeeAllBudgets,
            order: 3,
          ),
        ],
      );
    });
  }
}

class _AlertsView extends StatelessWidget {
  const _AlertsView({Key key, this.alerts}) : super(key: key);

  final List<AlertData> alerts;

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    return Container(
      padding: const EdgeInsetsDirectional.only(start: 16, top: 4, bottom: 4),
      color: RallyColors.cardBackground,
      Column(
        [
          Container(
            width: double.infinity,
            padding:
                isDesktop ? const EdgeInsets.symmetric(vertical: 16) : null,
            MergeSemantics(
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                [
                  Text(GalleryLocalizations.of(context).rallyAlerts),
                  if (!isDesktop)
                    TextButton(
                      style: TextButton.styleFrom(primary: Colors.white),
                      onPressed: () {},
                      Text(GalleryLocalizations.of(context).rallySeeAll),
                    ),
                ],
              ),
            ),
          ),
          for (AlertData alert in alerts) ...[
            Container(color: RallyColors.primaryBackground, height: 1),
            _Alert(alert: alert),
          ]
        ],
      ),
    );
  }
}

class _Alert extends StatelessWidget {
  const _Alert({
    Key key,
    @required this.alert,
  }) : super(key: key);

  final AlertData alert;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      Container(
        padding: isDisplayDesktop(context)
            ? const EdgeInsets.symmetric(vertical: 8)
            : null,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          Expanded(
            Text(alert.message),
          ),
          SizedBox(
            width: 100,
            Align(
              alignment: Alignment.topRight,
              IconButton(
                onPressed: () {},
                icon: Icon(alert.iconData, color: RallyColors.white60),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FinancialView extends StatelessWidget {
  const _FinancialView({
    this.title,
    this.total,
    this.financialItemViews,
    this.buttonSemanticsLabel,
    this.order,
  });

  final String title;
  final String buttonSemanticsLabel;
  final double total;
  final List<FinancialEntityCategoryView> financialItemViews;
  final double order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FocusTraversalOrder(
      order: NumericFocusOrder(order),
      Container(
        color: RallyColors.cardBackground,
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          [
            MergeSemantics(
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                  ),
                  Text(title),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  Text(
                    usdWithSignFormat(context).format(total),
                    style: theme.textTheme.bodyText1.copyWith(
                      fontSize: 44 / reducedTextScale(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            ...financialItemViews.sublist(
                0, math.min(financialItemViews.length, 3)),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () {},
              Text(
                GalleryLocalizations.of(context).rallySeeAll,
                semanticsLabel: buttonSemanticsLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
