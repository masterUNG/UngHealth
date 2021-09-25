import 'package:flutter/material.dart';
import 'package:unghealth/utility/my_constant.dart';
import 'package:unghealth/widgets/build_signout.dart';
import 'package:unghealth/widgets/show_title.dart';

class UserService extends StatefulWidget {
  const UserService({Key? key}) : super(key: key);

  @override
  _UserServiceState createState() => _UserServiceState();
}

class _UserServiceState extends State<UserService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
        backgroundColor: MyConstant.primary,
      ),
      drawer: Drawer(
        child: BuildSignOut(),
      ),
    );
  }

  
}
