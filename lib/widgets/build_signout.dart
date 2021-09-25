import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unghealth/utility/my_constant.dart';
import 'package:unghealth/widgets/show_title.dart';

class BuildSignOut extends StatelessWidget {
  const BuildSignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear().then((value) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.routeAuthen, (route) => false));
          },
          tileColor: Colors.red.shade700,
          leading: Icon(
            Icons.exit_to_app,
            size: 36,
            color: Colors.white,
          ),
          title: ShowTitle(
            title: 'Sign Out',
            textStyle: MyConstant().h2wStyle(),
          ),
          subtitle: ShowTitle(
            title: 'ออกจาก แอพ กลับ ไปหน้า Authen',
            textStyle: MyConstant().h3wStyle(),
          ),
        ),
      ],
    );
  }
}
