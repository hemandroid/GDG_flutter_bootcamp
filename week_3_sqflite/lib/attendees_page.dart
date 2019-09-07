import 'package:flutter/material.dart';
import 'package:snappable/snappable.dart';
import 'package:week_3_sqflite/db/attendees_db.dart';
import 'package:week_3_sqflite/db/model/attendees_model.dart';
import 'package:week_3_sqflite/registration_form.dart';
import 'package:week_3_sqflite/transitions/slide_bottom_up.dart';

void main() => runApp(AttendeesPageWidget());

class AttendeesPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AttendeesPageUI(),
    );
  }
}

class AttendeesPageUI extends StatefulWidget {
  @override
  _AttendeesPageState createState() => _AttendeesPageState();
}

class _AttendeesPageState extends State<AttendeesPageUI> {
  /// GlobalKey used to delete the data to apply with Snappable animation
  GlobalKey<SnappableState> allDeleteKey;

  /// DB Helper initialization
  AttendeesDataBaseHelper _dataBaseHelper;

  /// List initialization to add the set of data after reading from DB
  List<Attendees> _attendeesList;

  /// Initial method which was triggered after launching the app before loading the Build widget
  @override
  void initState() {
    super.initState();
    _dataBaseHelper = new AttendeesDataBaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendees List',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[

          /// Deleting the complete list of user data
          IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: () {
                _dataBaseHelper.deleteAllUsers();
                allDeleteKey.currentState.snap();
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {});
                });
              })
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, SlideRightRoute(page: RegistrationFormWidget()));
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildUI(context),
        ),
      ),
    );
  }

  _buildUI(BuildContext context) {
    return FutureBuilder<List<Attendees>>(
      future: _dataBaseHelper.getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _attendeesList = snapshot.data;
          return _attendeesListUI(context);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  _attendeesListUI(BuildContext context) {
    allDeleteKey = GlobalKey<SnappableState>();
    return Snappable(
      key: allDeleteKey,
      duration: Duration(
        seconds: 2,
      ),
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _attendeesList == null ? 0 : _attendeesList.length,
          itemBuilder: (BuildContext context, int index) {
            GlobalKey<SnappableState> snapKey = GlobalKey<SnappableState>();

            return Snappable(
              key: snapKey,
              duration: Duration(
                seconds: 2,
              ),
              child: Card(
                child: new Container(
                    child: new Center(
                      child: new Row(
                        children: <Widget>[
                          new CircleAvatar(
                            radius: 30.0,
                            child:
                                new Text(getShortName(_attendeesList[index])),
                            backgroundColor: const Color(0xFF20283e),
                          ),
                          Expanded(
                            child: new Padding(
                              padding: EdgeInsets.all(10.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    _attendeesList[index].firstname +
                                        " " +
                                        _attendeesList[index].lastname,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.lightBlueAccent),
                                  ),
                                  new Text(
                                    "State " + _attendeesList[index].stateName,
                                    style: new TextStyle(
                                        fontSize: 20.0, color: Colors.amber),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: const Color(0xFF167F67),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return RegistrationFormWidget(
                                      attendees: _attendeesList[index],
                                      isUpdate: true,
                                    );
                                  }));
                                },
                              ),
                              new IconButton(
                                  icon: const Icon(Icons.delete_forever,
                                      color: const Color(0xFF167F67)),
                                  onPressed: () {
                                    _deleteAttendee(
                                        _attendeesList[index], index, snapKey);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
              ),
            );
          }),
    );
  }

  _deleteAttendee(
      Attendees attendee, int index, GlobalKey<SnappableState> snapKey) async {
    await _dataBaseHelper.deleteUsers(attendee);
    snapKey.currentState.snap();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {});
    });
  }

  String getShortName(Attendees attendees) {
    String shortName = "";
    if (attendees.firstName.isNotEmpty) {
      shortName = attendees.firstName.substring(0, 1) + ".";
    }

    if (attendees.lastName.isNotEmpty) {
      shortName = shortName + attendees.lastName.substring(0, 1);
    }
    return shortName;
  }
}
