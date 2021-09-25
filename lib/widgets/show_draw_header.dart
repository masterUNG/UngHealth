import 'package:flutter/material.dart';
import 'package:unghealth/model/user_model.dart';
import 'package:unghealth/utility/my_constant.dart';
import 'package:unghealth/widgets/show_image.dart';
import 'package:unghealth/widgets/show_title.dart';

class ShowDrawerHeader extends StatelessWidget {
  final UserModel userModel;
  const ShowDrawerHeader({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(currentAccountPicture: userModel.avatar.isEmpty ? ShowImage(path: 'images/image4.png') :  null,
      decoration: BoxDecoration(color: MyConstant.light),
      accountName: ShowTitle(
        title: userModel.name,
        textStyle: MyConstant().h2wStyle(),
      ),
      accountEmail: ShowTitle(
        title: userModel.typeUser,
        textStyle: MyConstant().h3wStyle(),
      ),
    );
  }
}
