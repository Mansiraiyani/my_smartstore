import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_smartstore/constants.dart';

import '../models/category_model.dart';

class CategoryItem extends StatelessWidget {

  late String image,name;


  CategoryItem(CategoryModel categoryModel){
    image = categoryModel.image!;
    name = categoryModel.name!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: HOST_URL + image,
            fit: BoxFit.contain,
            height: 40,
            width: 40,),
          SizedBox(height: 4,),
          Text(name,
            textAlign:TextAlign.center,maxLines:2,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,height: 1,color: Colors.black),)
        ],
      ),
    );
  }
}
