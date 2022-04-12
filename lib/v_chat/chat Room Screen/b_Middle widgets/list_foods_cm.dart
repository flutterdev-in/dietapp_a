import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/x_customWidgets/url_preview_avatar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class ListFoodsCM extends StatelessWidget {
  final List<FoodsCollectionModel> listFoods;
  const ListFoodsCM({Key? key, required this.listFoods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 100,
        minHeight: 50,
      ),
      child: ListView.builder(
        itemCount: listFoods.length,
        itemBuilder: (context, index) {
          FoodsCollectionModel fm = listFoods[index];
          if (fm.webURL!=null && fm.imgURL!=null){
            return GFListTile(
            avatar: urlPreviewAvatar(url: fm.webURL!, imgURL: fm.imgURL!),
            title: Text(fm.fieldName),
          );
          }else{
            return SizedBox();
          }
          
        },
      ),
    );
  }
}
