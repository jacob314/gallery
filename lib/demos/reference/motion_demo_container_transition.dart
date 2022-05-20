// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

// BEGIN openContainerTransformDemo

const String _loremIpsumParagraph =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
    'tempor incididunt ut labore et dolore magna aliqua. Vulputate dignissim '
    'suspendisse in est. Ut ornare lectus sit amet. Eget nunc lobortis mattis '
    'aliquam faucibus purus in. Hendrerit gravida rutrum quisque non tellus '
    'orci ac auctor. Mattis aliquam faucibus purus in massa. Tellus rutrum '
    'tellus pellentesque eu tincidunt tortor. Nunc eget lorem dolor sed. Nulla '
    'at volutpat diam ut venenatis tellus in metus. Tellus cras adipiscing enim '
    'eu turpis. Pretium fusce id velit ut tortor. Adipiscing enim eu turpis '
    'egestas pretium. Quis varius quam quisque id. Blandit aliquam etiam erat '
    'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
    'gravida rutrum quisque. Suspendisse in est ante in nibh mauris cursus '
    'mattis molestie. Adipiscing elit duis tristique sollicitudin nibh sit '
    'amet commodo nulla. Pretium viverra suspendisse potenti nullam ac tortor '
    'vitae.\n'
    '\n'
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
    'tempor incididunt ut labore et dolore magna aliqua. Vulputate dignissim '
    'suspendisse in est. Ut ornare lectus sit amet. Eget nunc lobortis mattis '
    'aliquam faucibus purus in. Hendrerit gravida rutrum quisque non tellus '
    'orci ac auctor. Mattis aliquam faucibus purus in massa. Tellus rutrum '
    'tellus pellentesque eu tincidunt tortor. Nunc eget lorem dolor sed. Nulla '
    'at volutpat diam ut venenatis tellus in metus. Tellus cras adipiscing enim '
    'eu turpis. Pretium fusce id velit ut tortor. Adipiscing enim eu turpis '
    'egestas pretium. Quis varius quam quisque id. Blandit aliquam etiam erat '
    'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
    'gravida rutrum quisque. Suspendisse in est ante in nibh mauris cursus '
    'mattis molestie. Adipiscing elit duis tristique sollicitudin nibh sit '
    'amet commodo nulla. Pretium viverra suspendisse potenti nullam ac tortor '
    'vitae';

const double _fabDimension = 56;

class OpenContainerTransformDemo extends StatefulWidget {
  const OpenContainerTransformDemo({Key key}) : super(key: key);

  @override
  _OpenContainerTransformDemoState createState() =>
      _OpenContainerTransformDemoState();
}

class _OpenContainerTransformDemoState
    extends State<OpenContainerTransformDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  void _showSettingsBottomModalSheet(BuildContext context) {
    final localizations = GalleryLocalizations.of(context);

    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: 125,
              padding: const EdgeInsets.all(15),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                  Text(
                    localizations.demoContainerTransformModalBottomSheetTitle,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ToggleButtons(
                    borderRadius: BorderRadius.circular(2),
                    selectedBorderColor: Theme.of(context).colorScheme.primary,
                    onPressed: (index) {
                      setModalState(() {
                        setState(() {
                          _transitionType = index == 0
                              ? ContainerTransitionType.fade
                              : ContainerTransitionType.fadeThrough;
                        });
                      });
                    },
                    isSelected: <bool>[
                      _transitionType == ContainerTransitionType.fade,
                      _transitionType == ContainerTransitionType.fadeThrough,
                    ],
                    
                      Text(
                        localizations.demoContainerTransformTypeFade,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                         Text(
                          localizations.demoContainerTransformTypeFadeThrough,
                        ),
                      )
                    ,
                  )
                ,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = GalleryLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Navigator(
      // Adding [ValueKey] to make sure that the widget gets rebuilt when
      // changing type.
      key: ValueKey(_transitionType),
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(
          builder: (context) => Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Column(
                
                  Text(
                    localizations.demoContainerTransformTitle,
                  ),
                  Text(
                    '(${localizations.demoContainerTransformDemoInstructions})',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.white),
                  )
                ,
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                  ),
                  onPressed: () {
                    _showSettingsBottomModalSheet(context);
                  },
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(8),
               [
                _OpenContainerWrapper(
                  transitionType: _transitionType,
                  closedBuilder: (context, openContainer) {
                    return _DetailsCard(openContainer: openContainer);
                  },
                ),
                const SizedBox(height: 16),
                _OpenContainerWrapper(
                  transitionType: _transitionType,
                  closedBuilder: (context, openContainer) {
                    return _DetailsListTile(openContainer: openContainer);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  
                    Expanded(
                       _OpenContainerWrapper(
                        transitionType: _transitionType,
                        closedBuilder: (context, openContainer) {
                          return _SmallDetailsCard(
                            openContainer: openContainer,
                            subtitle:
                                localizations.demoMotionPlaceholderSubtitle,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                       _OpenContainerWrapper(
                        transitionType: _transitionType,
                        closedBuilder: (context, openContainer) {
                          return _SmallDetailsCard(
                            openContainer: openContainer,
                            subtitle:
                                localizations.demoMotionPlaceholderSubtitle,
                          );
                        },
                      ),
                    )
                  ,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  
                    Expanded(
                       _OpenContainerWrapper(
                        transitionType: _transitionType,
                        closedBuilder: (context, openContainer) {
                          return _SmallDetailsCard(
                            openContainer: openContainer,
                            subtitle: localizations
                                .demoMotionSmallPlaceholderSubtitle,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                       _OpenContainerWrapper(
                        transitionType: _transitionType,
                        closedBuilder: (context, openContainer) {
                          return _SmallDetailsCard(
                            openContainer: openContainer,
                            subtitle: localizations
                                .demoMotionSmallPlaceholderSubtitle,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                       _OpenContainerWrapper(
                        transitionType: _transitionType,
                        closedBuilder: (context, openContainer) {
                          return _SmallDetailsCard(
                            openContainer: openContainer,
                            subtitle: localizations
                                .demoMotionSmallPlaceholderSubtitle,
                          );
                        },
                      ),
                    )
                  ,
                ),
                const SizedBox(
                  height: 16,
                ),
                ...List.generate(10, (index) {
                  return OpenContainer<bool>(
                    transitionType: _transitionType,
                    openBuilder: (context, openContainer) =>
                        const _DetailsPage(),
                    tappable: false,
                    closedShape: const RoundedRectangleBorder(),
                    closedElevation: 0,
                    closedBuilder: (context, openContainer) {
                      return ListTile(
                        leading: Image.asset(
                          'placeholders/avatar_logo.png',
                          package: 'flutter_gallery_assets',
                          width: 40,
                        ),
                        onTap: openContainer,
                        title: Text(
                          localizations.demoMotionListTileTitle +
                              ' ${index + 1}',
                        ),
                        subtitle: Text(
                          localizations.demoMotionPlaceholderSubtitle,
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
            floatingActionButton: OpenContainer(
              transitionType: _transitionType,
              openBuilder: (context, openContainer) => const _DetailsPage(),
              closedElevation: 6,
              closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(_fabDimension / 2),
                ),
              ),
              closedColor: colorScheme.secondary,
              closedBuilder: (context, openContainer) {
                return SizedBox(
                  height: _fabDimension,
                  width: _fabDimension,
                   Center(
                     Icon(
                      Icons.add,
                      color: colorScheme.onSecondary,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    this.closedBuilder,
    this.transitionType,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (context, openContainer) => const _DetailsPage(),
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({this.openContainer});

  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    final localizations = GalleryLocalizations.of(context);

    return _InkWellOverlay(
      openContainer: openContainer,
      height: 300,
       Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        
          Expanded(
             Container(
              color: Colors.black38,
               Center(
                 Image.asset(
                  'placeholders/placeholder_image.png',
                  package: 'flutter_gallery_assets',
                  width: 100,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              localizations.demoMotionPlaceholderTitle,
            ),
            subtitle: Text(
              localizations.demoMotionPlaceholderSubtitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
             Text(
              'Lorem ipsum dolor sit amet, consectetur '
              'adipiscing elit, sed do eiusmod tempor.',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.black54,
                    inherit: false,
                  ),
            ),
          )
        ,
      ),
    );
  }
}

class _SmallDetailsCard extends StatelessWidget {
  const _SmallDetailsCard({
    this.openContainer,
    this.subtitle,
  });

  final VoidCallback openContainer;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return _InkWellOverlay(
      openContainer: openContainer,
      height: 225,
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
          Container(
            color: Colors.black38,
            height: 150,
             Center(
               Image.asset(
                'placeholders/placeholder_image.png',
                package: 'flutter_gallery_assets',
                width: 80,
              ),
            ),
          ),
          Expanded(
             Padding(
              padding: const EdgeInsets.all(10),
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                
                  Text(
                    GalleryLocalizations.of(context).demoMotionPlaceholderTitle,
                    style: textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    subtitle,
                    style: textTheme.caption,
                  )
                ,
              ),
            ),
          )
        ,
      ),
    );
  }
}

class _DetailsListTile extends StatelessWidget {
  const _DetailsListTile({this.openContainer});

  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const height = 120.0;

    return _InkWellOverlay(
      openContainer: openContainer,
      height: height,
       Row(
        
          Container(
            color: Colors.black38,
            height: height,
            width: height,
             Center(
               Image.asset(
                'placeholders/placeholder_image.png',
                package: 'flutter_gallery_assets',
                width: 60,
              ),
            ),
          ),
          Expanded(
             Padding(
              padding: const EdgeInsets.all(20),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                  Text(
                    GalleryLocalizations.of(context).demoMotionPlaceholderTitle,
                    style: textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur '
                    'adipiscing elit,',
                    style: textTheme.caption,
                  )
                ,
              ),
            ),
          )
        ,
      ),
    );
  }
}

class _InkWellOverlay extends StatelessWidget {
  const _InkWellOverlay({
    this.openContainer,
    this.width,
    this.height,
    this.child,
  });

  final VoidCallback openContainer;
  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
       InkWell(
        onTap: openContainer,
         child,
      ),
    );
  }
}

class _DetailsPage extends StatelessWidget {
  const _DetailsPage();

  @override
  Widget build(BuildContext context) {
    final localizations = GalleryLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.demoMotionDetailsPageTitle,
        ),
      ),
      body: ListView(
        
          Container(
            color: Colors.black38,
            height: 250,
             Padding(
              padding: const EdgeInsets.all(70),
               Image.asset(
                'placeholders/placeholder_image.png',
                package: 'flutter_gallery_assets',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
                Text(
                  localizations.demoMotionPlaceholderTitle,
                  style: textTheme.headline5.copyWith(
                    color: Colors.black54,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _loremIpsumParagraph,
                  style: textTheme.bodyText2.copyWith(
                    color: Colors.black54,
                    height: 1.5,
                    fontSize: 16,
                  ),
                )
              ,
            ),
          )
        ,
      ),
    );
  }
}

// END openContainerTransformDemo
