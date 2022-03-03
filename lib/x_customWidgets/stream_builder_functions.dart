import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';


  docStreamReturn(BuildContext c, AsyncSnapshot<DocumentSnapshot> d,
      {Widget errorW = const Text('Error'),
      Widget loadingW = const GFShimmer(child: Text("Loading..")),
      Widget nodataW = const Text('Data not exists'),
      String widType = "default"}) {
    if (d.hasError) {
      if (widType == "default") {
        return errorW;
      } else {
        return const ListTile(leading: Icon(Icons.error),
        title: Text("Error in fetching data"));
      }
    }

    if (d.hasData && !d.data!.exists) {
      if (widType == "default") {
        return nodataW;
      } else {
        return const ListTile(leading: Icon(Icons.no_accounts),
        title: Text("Data not exists"));
      }
    }

    if (d.hasData && d.data!.exists) {
      Map<String, dynamic> data = d.data!.data() as Map<String, dynamic>;
      return data;
    } else {
      if (widType == "default") {
        return nodataW;
      } else {
        return const GFShimmer(
          child: ListTile(leading: Icon(FontAwesomeIcons.spinner),
          title: Text("Loading please wait")),
        );
      }
    }
  }

