import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverTest extends StatelessWidget {
  const SliverTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(child: Text(index.toString())),
              );
            },
            childCount: 19,
            semanticIndexOffset: 1,
          )),
          SliverPinnedHeader(
              child: Container(
            child: Text("dfvdvfffdv\ndsnjndvdvndndvnvv"),
            width: double.maxFinite,
            color: Colors.white,
          )),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(child: Text(index.toString() + " second")),
            );
          }, childCount: 19)),
        ],
      ),
    );
  }
}
