import 'package:flutter/material.dart';

AppBar getAppBar({required String title}) {
  return AppBar(
    leading: BackButton(),
    backgroundColor: Color(0xff22987f),
    title: Text(title),
    centerTitle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(35),
        bottomRight: Radius.circular(35),
      ),
    ),
  );
}

FloatingActionButton fab({Function()? onPressed}) {
  return FloatingActionButton(
    onPressed: onPressed,
    backgroundColor: Color(0xff22987f),
    child: Icon(Icons.add),
  );
}
