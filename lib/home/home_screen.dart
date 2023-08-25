import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_smartstore/home/fragments/home_fragment/home_fragment.dart';
import 'package:my_smartstore/registration/authentication/auth_cubit.dart';
import 'package:my_smartstore/registration/authentication/auth_state.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class HomeScreen extends StatefulWidget {
  final drawerItems = [
    DrawerItem('Home', Icons.home),
    DrawerItem('My Orders', Icons.shopping_bag),
    DrawerItem('My Cart', Icons.shopping_cart),
    DrawerItem('My Wishlist', Icons.favorite_outlined),
    DrawerItem('My Account', Icons.account_circle),
  ];

  final HomeFragment _homeFragment = const HomeFragment();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: _selectedDrawerIndex == 0
            ? [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {},
                ),
              ]
            : null,
        titleSpacing: 0,
        title: _selectedDrawerIndex == 0
            ? Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text('Toy Joy')
                ],
              )
            : Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: _createDrawerOptions(),
          ),
        ),
      ),
      body: _getDrawerItemFragment(_selectedDrawerIndex),
    );
  }

  _createDrawerOptions() {
    String email = 'Email', name = "FullName";
    Authstate authstate = BlocProvider.of<AuthCubit>(context).state;
    if (authstate is Authenticated) {
      email = authstate.userdata.email!;
      name = authstate.userdata.fullname!;
    }

    var drawerOptions = <Widget>[
      UserAccountsDrawerHeader(
          accountName: Text(name), accountEmail: Text(email))
    ];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(Container(
        child: ListTile(
          leading: Icon(d.icon),
          title: Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () {
            setState(() {
              _selectedDrawerIndex = i;
            });
            Navigator.pop(context);
          },
        ),
      ));
    }
    return drawerOptions;
  }

  _getDrawerItemFragment(int selectedDrawerIndex) {
    switch (selectedDrawerIndex) {
      case 0:
        return widget._homeFragment;
      default:
        return const Text("Error");
    }
  }
}
