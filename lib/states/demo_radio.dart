import 'package:flutter/material.dart';

class DemoRadio extends StatefulWidget {
  const DemoRadio({Key? key}) : super(key: key);

  @override
  _DemoRadioState createState() => _DemoRadioState();
}

class _DemoRadioState extends State<DemoRadio> {
  List<Widget> widgets = [];
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widgets.add(filedOne());
    widgets.add(filedTwo());
    widgets.add(filedThree());
    widgets.add(filedFour());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          optionOne(),
          optionTwo(),
          optionThree(),
          optionFour(),
          widgets[index],
        ],
      ),
    );
  }

  Column filedOne() {
    return Column(
      children: [
        Container(
          width: 250,
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Column filedTwo() {
    return Column(
      children: [
        Container(
          width: 250,
          margin: EdgeInsets.only(top: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: 250,
          margin: EdgeInsets.only(top: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Column filedThree() {
    return Column(
      children: [
        Container(
          width: 250,
          margin: EdgeInsets.only(top: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: 250,
          margin: EdgeInsets.only(top: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: 250,
          margin: EdgeInsets.only(top: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Column filedFour() {
    return Column(
      children: [
        Container(
          width: 250,
          margin: EdgeInsets.only(top: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: 250,
          margin: EdgeInsets.only(top: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: 250,
          margin: EdgeInsets.only(top: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          width: 250,
          margin: EdgeInsets.only(top: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  RadioListTile<int> optionOne() {
    return RadioListTile(
      title: Text('Option 1'),
      value: 0,
      groupValue: index,
      onChanged: (value) {
        setState(() {
          index = value!;
        });
      },
    );
  }

  RadioListTile<int> optionTwo() {
    return RadioListTile(
      title: Text('Option 2'),
      value: 1,
      groupValue: index,
      onChanged: (value) {
        setState(() {
          index = value!;
        });
      },
    );
  }

  RadioListTile<int> optionThree() {
    return RadioListTile(
      title: Text('Option 3'),
      value: 2,
      groupValue: index,
      onChanged: (value) {
        setState(() {
          index = value!;
        });
      },
    );
  }

  RadioListTile<int> optionFour() {
    return RadioListTile(
      title: Text('Option 4'),
      value: 3,
      groupValue: index,
      onChanged: (value) {
        setState(() {
          index = value!;
        });
      },
    );
  }
}
