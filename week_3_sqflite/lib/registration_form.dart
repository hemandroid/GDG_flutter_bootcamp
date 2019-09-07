import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week_3_sqflite/db/attendees_db.dart';
import 'package:week_3_sqflite/db/model/attendees_model.dart';

class RegistrationFormWidget extends StatelessWidget {
  final Attendees attendees;
  final bool isUpdate;

  RegistrationFormWidget({this.attendees, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RegistrationFormUI(
        attendees: attendees,
        isUpdate: isUpdate,
      ),
    );
  }
}

class RegistrationFormUI extends StatefulWidget {
  final Attendees attendees;
  final bool isUpdate;

  RegistrationFormUI({this.attendees, this.isUpdate = false});
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationFormUI> {
  int selectedRadioTile;
  Attendees _attendees;
  AttendeesDataBaseHelper _dataBaseHelper;
  String firstName;
  String lastName;
  String password;
  String reEnterPassword;
  String mobile;
  String emailId;
  int gender;
  String city;
  String state;
  String address;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
    if (widget.isUpdate && widget.attendees != null) {
      firstNameController.text = firstName = widget.attendees.firstName ?? "";
      lastNameController.text = lastName = widget.attendees.lastName ?? "";
      passwordController.text = password = widget.attendees.password ?? "";
      reEnterPasswordController.text =
          reEnterPassword = widget.attendees.reEnterPassword ?? "";
      mobileController.text = mobile = widget.attendees.mobileNumber ?? "";
      emailIdController.text = emailId = widget.attendees.emailId ?? "";
      selectedRadioTile = gender = widget.attendees.gender ?? 0;
      cityController.text = city = widget.attendees.city ?? "";
      stateController.text = state = widget.attendees.state ?? "";
      addressController.text = address = widget.attendees.address ?? "";

      _attendees = widget.attendees;
      _attendees = widget.attendees;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        // This line of code will remove the default < button
        title: Text(
          'Registration Form',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: _buildUI(context),
      ),
    );
  }

  _buildUI(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: firstNameController,
            onChanged: (value) {
              firstName = value;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Please Enter your first name',
                helperText: 'First Name section',
                labelText: 'First Name'),
            maxLines: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
          ),
          TextField(
            controller: lastNameController,
            onChanged: (value) {
              lastName = value;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Please Enter your last name',
                helperText: 'Last Name section',
                labelText: 'Last Name'),
            maxLines: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
          ),
          TextField(
            controller: passwordController,
            onChanged: (value) {
              password = value;
            },
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Please Enter New Password',
                helperText: 'New Password',
                labelText: 'Password'),
            maxLines: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
          ),
          TextField(
            controller: reEnterPasswordController,
            onChanged: (value) {
              reEnterPassword = value;
            },
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Please Enter your password again',
                helperText: 'Re-Enter password',
                labelText: 'Re-enter password'),
            maxLines: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
          ),
          TextField(
            controller: mobileController,
            onChanged: (value) {
              mobile = value;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Please Enter your 10 digit mobile number',
                helperText: 'Mobile Number section',
                labelText: 'Mobile'),
            maxLines: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
          ),
          TextField(
            controller: emailIdController,
            onChanged: (value) {
              emailId = value;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Please Enter your Email ID',
                helperText: 'Your personal Email-ID',
                labelText: 'Email-id'),
            maxLines: 1,
          ),
          Row(
            children: <Widget>[
              _genderSection(
                  context: context,
                  title: 'Male',
                  value: 1,
                  groupValue: selectedRadioTile,
                  onChanged: (value) {
                    debugPrint('Male selected');
                    setSelectedRadioTile(value);
                  }),
              _genderSection(
                  context: context,
                  title: 'Female',
                  value: 2,
                  groupValue: selectedRadioTile,
                  onChanged: (value) {
                    debugPrint('Female selected');
                    setSelectedRadioTile(value);
                  }),
            ],
          ),
          TextField(
            controller: cityController,
            onChanged: (value) {
              city = value;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'City',
                helperText: 'Your current city',
                labelText: 'City'),
            maxLines: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
          ),
          TextField(
            controller: stateController,
            onChanged: (value) {
              state = value;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'State',
                helperText: 'Please enter your state',
                labelText: 'State'),
            maxLines: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
          ),
          TextField(
            controller: addressController,
            onChanged: (value) {
              debugPrint('Address value ' + value);
              address = value;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Please Enter Address',
                helperText: 'Address',
                labelText: 'Address'),
            maxLines: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
          ),
          _submitButton(context),
          Padding(
            padding: const EdgeInsets.all(10.0),
          ),
        ],
      ),
    );
  }

  _submitButton(BuildContext context) {
    return RawMaterialButton(
      splashColor: Colors.red[400],
      fillColor: Colors.blue,
      padding: EdgeInsets.all(15),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {
        _addAttendeesRecord(context);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
        child: Text(
          widget.isUpdate ? 'Update' :  'Submit',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }

  _genderSection(
      {BuildContext context,
      String title,
      int value,
      int groupValue,
      Function onChanged}) {
    return Flexible(
      fit: FlexFit.tight,
      child: RadioListTile(
        selected: true,
        activeColor: Colors.blue,
        value: value,
        groupValue: groupValue,
        title: Text(
          title,
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Future _addAttendeesRecord(BuildContext context) async {
    print(firstName);
    _dataBaseHelper = AttendeesDataBaseHelper();

    if(!widget.isUpdate) {
      _attendees = new Attendees(
        firstName: firstName,
        lastName: lastName,
        mobileNumber: mobile,
        gender: gender,
        city: city,
        state: state,
        address: address,
        emailId: emailId,
        password: password,
        reEnterPassword: reEnterPassword,
      );
      _attendees.setUserId(this._attendees.id);
      await _dataBaseHelper.saveAttendeesDetails(_attendees);
    } else {
      _attendees.firstName = firstName;
      _attendees.lastName = lastName;
      _attendees.mobileNumber = mobile;
      _attendees.gender = gender;
      _attendees.city = city;
      _attendees.state = state;
      _attendees.address = address;
      _attendees.emailId = emailId;
      _attendees.password = password;
      _attendees.reEnterPassword = reEnterPassword;

      _attendees.setUserId(this._attendees.id);
      await _dataBaseHelper.update(_attendees);
    }
    debugPrint(_attendees.toString());

    Navigator.of(context).pop();
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      gender = selectedRadioTile;
    });
  }
}
