import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_smartstore/MyWidgets/category_item.dart';
import 'package:my_smartstore/home/fragments/home_fragment/home_fragment_state.dart';

import 'home_fragment_cubit.dart';


class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeFragmentCubit, HomeFragmentState>(
        listener: (context, state) {},

        builder: (context, state) {
          if (state is HomeFragmentInitial) {
            BlocProvider.of<HomeFragmentCubit>(context).loadCategories();
          }
          if (state is CategoriesLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  toolbarHeight: 150,
                  titleSpacing: 0,
                  backgroundColor: Colors.white,
                  title:Column(
                     children: [
                       Container(
                         padding: EdgeInsets.all(8),
                         child: ElevatedButton(
                             style: ButtonStyle(
                               elevation: MaterialStateProperty.all(0)
                             ),onPressed: (){}, child: const Padding(
                           padding: EdgeInsets.all(12.0),
                           child: Row(
                             children: [
                               Icon(Icons.search),Text('Search Here')
                             ],
                           ),
                         )),
                       ),
                       SizedBox(height:80,child:_categories(state),)
                     ],
                  )
                )
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
  _categories(state){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: state.categories.length,
        itemBuilder: (_, index) {
          return CategoryItem(state.categories[index]);
      });
  }
}
