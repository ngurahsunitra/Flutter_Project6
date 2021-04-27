import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_api_sample_app/src/api/api_service.dart';
import 'package:flutter_crud_api_sample_app/src/model/profile.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
  Profile profile;

  FormAddScreen({this.profile});

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldNameValid;
  bool _isFieldEmailValid;
  bool _isFieldAgeValid;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();

  @override
  void initState() {
    if (widget.profile != null) {
      _isFieldNameValid = true;
      _controllerName.text = widget.profile.name;
      _isFieldEmailValid = true;
      _controllerEmail.text = widget.profile.email;
      _isFieldAgeValid = true;
      _controllerAge.text = widget.profile.age.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.profile == null ? "Add Data" : "Edit Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldName(),
                _buildTextFieldEmail(),
                _buildTextFieldAge(),
                Container(
                  margin: EdgeInsets.only(left: 120, right: 110,),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      widget.profile == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldNameValid == null ||
                          _isFieldEmailValid == null ||
                          _isFieldAgeValid == null ||
                          !_isFieldNameValid ||
                          !_isFieldEmailValid ||
                          !_isFieldAgeValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String name = _controllerName.text.toString();
                      String email = _controllerEmail.text.toString();
                      int age = int.parse(_controllerAge.text.toString());
                      Profile profile =
                      Profile(name: name, email: email, age: age);
                      if (widget.profile == null) {
                        _apiService.createProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      } else {
                        profile.id = widget.profile.id;
                        _apiService.updateProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.cyan[900],
                  ),
                ),
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldName() {
    return Container(
      padding: const EdgeInsets.only(top:10.0),
      child: TextField(
        controller: _controllerName,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 25.0),
          icon: new Icon(Icons.person,
            color: Colors.cyan[900],
          ),
            border: new OutlineInputBorder(
              borderSide:
              new BorderSide(color: Colors.cyan[900]),
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              )
          ),
          labelText: "Full name",

          errorText: _isFieldNameValid == null || _isFieldNameValid
              ? null
              : "Full name is required",
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldNameValid) {
            setState(() => _isFieldNameValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _buildTextFieldEmail() {
    return Container(
      padding: const EdgeInsets.only(top:20.0),
        child: TextField(
          controller: _controllerEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 25.0),
            icon: new Icon(Icons.mail,
              color: Colors.cyan[900],
            ),
            border: new OutlineInputBorder(
                borderSide:
                new BorderSide(color: Colors.cyan[900]),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                )
            ),
            labelText: "Email",
            errorText: _isFieldEmailValid == null || _isFieldEmailValid
                ? null
                : "Email is required",
          ),
          onChanged: (value) {
            bool isFieldValid = value.trim().isNotEmpty;
            if (isFieldValid != _isFieldEmailValid) {
              setState(() => _isFieldEmailValid = isFieldValid);
            }
          },
        ),
    );
  }


  Widget _buildTextFieldAge() {
    return Container(
      padding: const EdgeInsets.only(top:20.0, bottom: 30),
        child: TextField(
          controller: _controllerAge,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 25.0),
            icon: new Icon(Icons.date_range_rounded,
              color: Colors.cyan[900],
            ),
            border: new OutlineInputBorder(
                borderSide:
                new BorderSide(color: Colors.cyan[900]),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                )
            ),
            labelText: "Age",
            errorText: _isFieldAgeValid == null || _isFieldAgeValid
                ? null
                : "Age is required",
          ),
          onChanged: (value) {
            bool isFieldValid = value.trim().isNotEmpty;
            if (isFieldValid != _isFieldAgeValid) {
              setState(() => _isFieldAgeValid = isFieldValid);
            }
          },
        ),
    );
  }
}
