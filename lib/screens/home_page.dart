import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kolbus_app/providers/backend_service_provider.dart';
import 'package:kolbus_app/providers/data_provider.dart';
// import 'package:kolbus_app/screens/backend.dart';
import 'package:kolbus_app/screens/route_card.dart';
import 'package:kolbus_app/screens/route_details.dart';
import 'package:kolbus_app/widgets/auto_field_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final sourceController = TextEditingController();
  final viaController = TextEditingController();
  final destController = TextEditingController();

  final sourceFocusNode = FocusNode();
  final viaFocusNode = FocusNode();
  final destFocusNode = FocusNode();

  bool firstRun = true;
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Sample Ad ID
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {});
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  void handleSearch() async {
    var searchRoutes = await ref.read(
      searchRoutesProvider(
        source: sourceController.text,
        via: viaController.text,
        destination: destController.text,
      ).future,
    );

    firstRun = false;

    sourceFocusNode.unfocus();
    viaFocusNode.unfocus();
    destFocusNode.unfocus();

    ref.read(dataProvider.notifier).setResults(searchRoutes);
  }

  @override
  void dispose() {
    sourceController.dispose();
    viaController.dispose();
    destController.dispose();

    sourceFocusNode.dispose();
    viaFocusNode.dispose();
    destFocusNode.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dp = ref.watch(dataProvider);
    final dn = ref.watch(dataProvider.notifier);

    return dp.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('KolBus'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              PopupMenuButton<String>(
                position: PopupMenuPosition.under,
                borderRadius: .circular(50.0),
                elevation: 10.0,
                onSelected: (value) async {
                  switch (value) {
                    case 'About':
                      context.push('/about');
                      break;
                    case 'Rate Us':
                      final url = Uri.parse(
                        'https://play.google.com/store/apps/details?id=com.centosys.kolbus',
                      );

                      if (await canLaunchUrl(url)) {
                        launchUrl(url);
                      } else {
                        debugPrint('Failed to launch URL');
                      }
                      break;
                  }
                },
                itemBuilder: (context) =>
                    [
                          ('About', Icons.info_outline),
                          ('Rate Us', Icons.star_outline),
                        ]
                        .map(
                          (e) => PopupMenuItem(
                            value: e.$1,
                            child: Row(
                              children: [
                                Icon(e.$2),
                                SizedBox(width: 10),
                                Text(e.$1),
                              ],
                            ),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  children: [
                    AutoFieldWidget(
                      label: "Source",
                      controller: sourceController,
                      focusNode: sourceFocusNode,
                      enabled: true,
                      suffix: sourceController.text.trim().isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  sourceController.clear();
                                });
                              },
                              icon: Icon(Icons.close_rounded),
                            )
                          : null,
                    ),
                    SizedBox(height: 1.5.h),
                    AutoFieldWidget(
                      label: "Via (optional)",
                      controller: viaController,
                      focusNode: viaFocusNode,
                      enabled: true,
                    ),
                    SizedBox(height: 1.5.h),
                    AutoFieldWidget(
                      label: "Destination",
                      controller: destController,
                      focusNode: destFocusNode,
                      enabled: true,
                      suffix:
                          (destController.text.trim().length >= 3 &&
                              data.allStops.contains(
                                destController.text.trim().toString(),
                              ) &&
                              destController.text.trim().toString() !=
                                  sourceController.text.trim().toString())
                          ? IconButton(
                              onPressed: () {
                                final source = sourceController.text.toString();
                                final destination = destController.text
                                    .toString();

                                if (source.trim().isNotEmpty &&
                                    destination.trim().isNotEmpty) {
                                  setState(() {
                                    sourceController.text = destination;
                                    sourceController.value = TextEditingValue(
                                      text: destination,
                                    );
                                    destController.text = source;
                                    destController.value = TextEditingValue(
                                      text: source,
                                    );
                                  });
                                }
                              },
                              icon: Icon(Icons.swap_vert),
                            )
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 100.w,
                  height: 6.h,
                  child: ElevatedButton(
                    onPressed: handleSearch,
                    child: Row(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'SEARCH',
                          style: TextStyle(fontSize: 18.sp, fontWeight: .w700),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: data.results.isEmpty
                      ? Center(
                          child: Text(
                            firstRun ||
                                    sourceController.text.trim().isEmpty ||
                                    destController.text.trim().isEmpty
                                ? "Fill details above and tap Search to see routes."
                                : "No bus routes",
                          ),
                        )
                      : ListView.builder(
                          itemCount: data.results.length,
                          itemBuilder: (context, index) {
                            final route = data.results[index];

                            return Container(
                              margin: .symmetric(horizontal: 1.w, vertical: 5),
                              child: OpenContainer(
                                clipBehavior: Clip.hardEdge,
                                transitionType:
                                    ContainerTransitionType.fadeThrough,
                                transitionDuration: const Duration(
                                  milliseconds: 500,
                                ),
                                closedColor: Theme.of(context).cardColor,
                                // closedElevation: 20,
                                closedShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    16.0,
                                  ),
                                ),

                                closedBuilder: (context, action) => RouteCard(
                                  route: route,
                                  source: sourceController.text,
                                  destination: destController.text,
                                  action: action,
                                ),

                                openBuilder: (context, action) =>
                                    RouteDetailsPage(
                                      route: route,
                                      source: sourceController.text,
                                      destination: destController.text,
                                    ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _bannerAd != null
              ? SizedBox(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                )
              : null,
          floatingActionButton: data.results.isNotEmpty
              ? FloatingActionButton(
                  onPressed: () {
                    sourceController.clear();
                    viaController.clear();
                    destController.clear();

                    dn.setResults([]);

                    sourceFocusNode.unfocus();
                    destFocusNode.unfocus();
                    viaFocusNode.unfocus();
                  },
                  child: Icon(Icons.settings_backup_restore),
                )
              : null,
        );
      },
      error: (error, stackTrace) {
        return TextButton(onPressed: () {}, child: const Text('Retry'));
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}