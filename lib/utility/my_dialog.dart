import 'package:flutter/material.dart';
import 'package:unghealth/utility/my_constant.dart';
import 'package:unghealth/widgets/show_image.dart';
import 'package:unghealth/widgets/show_title.dart';

class MyDialog {
  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: 'images/image2.png'),
          title: ShowTitle(
            title: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowTitle(title: message),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
        ],
      ),
    );
  }

  Future<Null> warnAddProfie(BuildContext context, String keyRoute) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: 'images/image3.png'),
          title: ShowTitle(
            title: 'No Profile ?',
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowTitle(title: 'Please Add Profile'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, keyRoute);
            },
            child: Text('Add Profile'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
