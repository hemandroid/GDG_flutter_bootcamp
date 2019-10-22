import 'package:flutter/material.dart';

void main() => runApp(UserProfilePageWidget());

class UserProfilePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserProfilePageUI(),
    );
  }
}

class UserProfilePageUI extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePageUI> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.blue,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: (){
            },
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.grey, fontSize: 25.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildUI(context),
        ),
      ),
    );
  }

  _buildUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _profileImageAndTitle(context),
        Padding(
          padding: const EdgeInsets.all(5.0),
        ),
        _profileInfo(context),
        Padding(
          padding: const EdgeInsets.all(8.0),
        ),
        _followAndMessageButtons(context),
        Padding(
          padding: const EdgeInsets.all(8.0),
        ),
        _aboutInfo(context),
        Padding(
          padding: const EdgeInsets.all(8.0),
        ),
        _skillsInfo(context),
      ],
    );
  }

  _profileImageAndTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
        ),
        Center(
          child: Container(
            child: CircleAvatar(
                radius: 90,
                backgroundImage: ExactAssetImage(
                  'assets/images/tony.jpg',
                ),
                backgroundColor: Colors.blue),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.deepOrange, offset: new Offset(-3.0, 3.0))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
        ),
        Text(
          'Tony Stark',
          style: TextStyle(
              fontSize: 23.0,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
        ),
        Text(
          'CEO of Stark Industries',
          style: TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
        ),
        Text(
          '10880 Malibu Point',
          style: TextStyle(
              fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  _profileInfo(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _countAndContent(
            context: context, countValue: '84', contentDescription: 'projects'),
        _verticalDivider(context),
        _countAndContent(
            context: context,
            countValue: '34.2k',
            contentDescription: 'followers'),
        _verticalDivider(context),
        _countAndContent(
            context: context,
            countValue: '458',
            contentDescription: 'following'),
      ],
    );
  }

  _countAndContent(
      {BuildContext context, String countValue, String contentDescription}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          countValue.toString(),
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0)
        ),
        Text(
          contentDescription,
          style: TextStyle(
              color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  _verticalDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 45.0,
        width: 1.0,
        color: Colors.grey,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      ),
    );
  }

  _followAndMessageButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          padding: const EdgeInsets.only(
              left: 40.0, right: 40.0, top: 10.0, bottom: 10.0),
          textColor: Colors.white,
          elevation: 0.5,
          highlightElevation: 2,
          color: Colors.blueAccent,
          child: Text(
            "Follow",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
          onPressed: () {},
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
        ),
        OutlineButton(
          padding: const EdgeInsets.only(
              left: 35.0, right: 35.0, top: 10.0, bottom: 10.0),
          textColor: Colors.blue,
          borderSide: BorderSide(color: Colors.blue),
          child: Text(
            'Message',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
          onPressed: () {},
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        )
      ],
    );
  }

  _aboutInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'About',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
          ),
          Text(
            "The outline button's border shape is defined by shape and its appearance is defined by borderSide, disabledBorderColor, and highlightedBorderColor. "
            "By default the border is a one pixel wide grey rounded rectangle that does not change when the button is pressed or disabled. By default the button's background is transparent.",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  _skillsInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Skills',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
          ),
          Wrap(
            spacing: 16.0,
            children: <Widget>[
              _skillChipsUI(context,
                  labelText: 'Android',
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'Material Design',
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'SQLite DB',
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'Google Maps',
                  backgroundColor: Colors.yellow,
                  textColor: Colors.black,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'DataBinding',
                  backgroundColor: Colors.amber,
                  textColor: Colors.black,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'RxJava',
                  backgroundColor: Colors.pink,
                  textColor: Colors.white,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'Google Maps',
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'Flutter',
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'Dart',
                  backgroundColor: Colors.indigo,
                  textColor: Colors.white,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'Firebase',
                  backgroundColor: Colors.orange,
                  textColor: Colors.white,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'Google Cloud',
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'Git',
                  backgroundColor: Colors.deepOrange,
                  textColor: Colors.white,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'GitHub',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'Android Studio',
                  backgroundColor: Colors.greenAccent,
                  textColor: Colors.black,
                  fontSize: 14.0),
              _skillChipsUI(context,
                  labelText: 'Restful',
                  backgroundColor: Colors.deepPurple,
                  textColor: Colors.white,
                  fontSize: 14.0),
            ],
          )
        ],
      ),
    );
  }

  _skillChipsUI(BuildContext context,
      {Color backgroundColor,
      String labelText,
      double fontSize,
      Color textColor}) {
    return Wrap(
      children: <Widget>[
        Chip(
          padding: const EdgeInsets.all(10.0),
          backgroundColor: backgroundColor,
          label: Text(
            labelText,
            maxLines: 2,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
          ),
        ),
      ],
    );
  }
}
