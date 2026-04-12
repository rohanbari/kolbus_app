import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolbus_app/models/route_model.dart';
import 'package:kolbus_app/screens/backend.dart';
import 'package:kolbus_app/screens/route_card.dart';
import 'package:kolbus_app/screens/route_details.dart';
import 'package:kolbus_app/vars.dart';
import 'package:kolbus_app/widgets/auto_field_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final sourceController = TextEditingController();
  final viaController = TextEditingController();
  final destController = TextEditingController();

  final sourceFocusNode = FocusNode();
  final viaFocusNode = FocusNode();
  final destFocusNode = FocusNode();

  var viaEnabled = false;

  @override
  void initState() {
    super.initState();
    initData();

    sourceController.addListener(() {
      if (sourceController.text.trim().length >= 3) {
        setState(() {
          viaEnabled = allStops.contains(sourceController.text.toString());
        });
      }
    });
  }

  Future<void> initData() async {
    final jsonString = await rootBundle.loadString('assets/routes.json');
    final jsonData = json.decode(jsonString);

    final loadedRoutes = (jsonData['routes'] as List)
        .map((e) => RouteModel.fromJson(e))
        .toList();

    setState(() {
      routes = loadedRoutes;
      aliases = Map<String, String>.from(jsonData['aliases']);

      allStops = {...routes.expand((r) => r.stops), ...aliases.keys};
    });
  }

  void handleSearch() {
    final res = searchRoutes(
      sourceController.text,
      viaController.text,
      destController.text,
    );

    firstRun = false;

    sourceFocusNode.unfocus();
    viaFocusNode.unfocus();
    destFocusNode.unfocus();

    setState(() {
      results = res;
    });
  }

  @override
  void dispose() {
    sourceController.dispose();
    viaController.dispose();
    destController.dispose();

    sourceFocusNode.dispose();
    viaFocusNode.dispose();
    destFocusNode.dispose();

    super.dispose();
  }

  bool firstRun = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KolBus'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                ),
                SizedBox(height: 1.5.h),
                AutoFieldWidget(
                  label: "Via (optional)",
                  controller: viaController,
                  focusNode: viaFocusNode,
                  enabled: viaEnabled,
                ),
                SizedBox(height: 1.5.h),
                AutoFieldWidget(
                  label: "Destination",
                  controller: destController,
                  focusNode: destFocusNode,
                  enabled: true,
                  suffix:
                      (destController.text.trim().length >= 3 &&
                          allStops.contains(
                            destController.text.trim().toString(),
                          ) &&
                          destController.text.trim().toString() !=
                              sourceController.text.trim().toString())
                      ? IconButton(
                          onPressed: () {
                            final source = sourceController.text.toString();
                            final destination = destController.text.toString();

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
              child: results.isEmpty
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
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final route = results[index];

                        return Container(
                          margin: .symmetric(horizontal: 1.w, vertical: 5),
                          child: OpenContainer(
                            clipBehavior: Clip.hardEdge,
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration: const Duration(milliseconds: 500),
                            closedColor: Theme.of(context).cardColor,
                            // closedElevation: 20,
                            closedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(16.0)
                            ),

                            closedBuilder: (context, action) => RouteCard(
                              route: route,
                              source: sourceController.text,
                              destination: destController.text,
                              action: action,
                            ),

                            openBuilder: (context, action) => RouteDetailsPage(
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
      floatingActionButton: results.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                sourceController.clear();
                viaController.clear();
                destController.clear();

                setState(() {
                  viaEnabled = false;
                  results.clear();
                  sourceFocusNode.unfocus();
                  destFocusNode.unfocus();
                  viaFocusNode.unfocus();
                });
              },
              child: Icon(Icons.settings_backup_restore),
            )
          : null,
    );
  }
}
