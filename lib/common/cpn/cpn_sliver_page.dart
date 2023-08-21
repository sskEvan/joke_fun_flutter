import 'package:flutter/material.dart';

abstract class CpnSliverPage extends StatelessWidget {
  CpnSliverPage({Key? key}) : super(key: key);

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, value) {
            return [
              buildSliverAppBar(context),
            ];
          },
          body: buildSliverBody(context)),
      // body: buildSliverBody(context, 0.0)),
    );
  }

  Widget buildSliverAppBar(BuildContext context);

  Widget buildSliverBody(BuildContext context);
}
