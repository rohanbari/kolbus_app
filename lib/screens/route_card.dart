import 'package:flutter/material.dart';
import 'package:kolbus_app/models/route_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RouteCard extends StatelessWidget {
  const RouteCard({
    super.key,
    required this.route,
    required this.source,
    required this.destination,
    required this.action,
  });

  final RouteModel route;
  final String source;
  final String destination;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Row(
        children: [
          Container(
            height: 15.h,
            width: 30.w,
            padding: .all(5.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
            ),
            child: Center(
              child: Wrap(
                children: [
                  Text(
                    route.routeId,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18.sp,
                      fontWeight: .bold,
                    ),
                    textAlign: .center,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 2.w),
          SizedBox(
            height: 15.h,
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              children: [
                Text(
                  'SOURCE',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12.sp,
                    fontWeight: .bold,
                  ),
                ),
                Text(
                  route.source,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),

                SizedBox(height: 1.h),

                Text(
                  'DESTINATION',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12.sp,
                    fontWeight: .bold,
                  ),
                ),
                Text(route.destination, style: TextStyle(fontSize: 16.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
