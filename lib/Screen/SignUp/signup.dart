import 'package:flutter/material.dart';
import 'package:flutter_taxi_user/Components/ink_well_custom.dart';
import 'package:flutter_taxi_user/Screen/Login/login.dart';
import 'package:flutter_taxi_user/theme/style.dart';
import 'package:flutter_taxi_user/Components/validations.dart';
import 'package:flutter_taxi_user/utility/global_func.dart';
import 'package:flutter_taxi_user/utility/network/ApiHelper.dart';
import 'package:flutter_taxi_user/utility/network/Constants.dart' as Constants;
import 'package:flutter_taxi_user/database/userinfo.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool autoValidate = false;
  Validations validations = new Validations();

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<String> DOMAINS = [
    'TAXIDEALS',
    'TAXIDEALS1',
    'TAXIDEALS2'
  ];

  List<String> CAR_TYPES = [

    'Taxi1',
    'Taxi2',
    'Taxi3',
    'Taxi4',

  ];
  String mDomain;
  String mCarType;


  @override
  void initState() {
    super.initState();
    mDomain = DOMAINS[0];
    mCarType = CAR_TYPES[3];

  }
  submit(){

    String email = emailController.text;
    String password = passwordController.text;
    String firstName = firstnameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;
    if (_formKey.currentState.validate()) {
      Map<String, dynamic> data = {
        "carType": mCarType,
        "category": "Taxi",
        "domain": mDomain,
        "email": email,
        "firstName": firstName,
        "id": "",
        "lastName": lastname,
        "latitude": 0,
        "longitude": 0,
        "password": password,
        "phoneNumber": phone,
        "phoneVerified": "1",
        "role": "ROLE_DRIVER",
        "token": fcmToken == null ? "" : fcmToken,
        "website": ""
      };
      showLoading(context);
      ApiHelper.postRequest(Constants.BASE_URL_SIGNUP, data).then((data) {
        hideDialog(context);
        if (data.status) {
          showToast("Registered succssfully.");
          Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new LoginScreen()));
        } else {
          showToast(data.message);
        }
      }).catchError((err) {
        hideDialog(context);
        print(err);
      });
    }
//    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new HomeScreen()));

  }
  fetchAlbum() async {
    Map<String, dynamic> data = {
      "category": "TAXI",
      "carType": mCarType,
      "domain": mDomain,
      "email": userinfo.email,
      "firstName": userinfo.firstname,
      "Lastname": userinfo.lastname,
      "latituse": "0",
      "longitude": "0",
      "password": userinfo.password,
      "phoneNumber": userinfo.phonenumber,
      "role": userinfo.role,
      "website": userinfo.website,
      "latitude": userinfo.latitude,
      // ignore: equal_keys_in_map
      "longitude": userinfo.longitude
    };

    ApiHelper.postRequest(Constants.BASE_URL_SIGNUP, data).then((data) {
      if (!data.status) {
      } else {
        print(data.message);
        if (data.status) {}
      }
    }).catchError((err) {
      print(err);
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: InkWellCustom(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(children: <Widget>[
                    Container(
                      height: 250.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/image/icon/Layer_2.png"),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    new Padding(
                        padding: EdgeInsets.fromLTRB(18.0, 80.0, 18.0, 0.0),
                        child: Container(
                            width: double.infinity,
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  //padding: EdgeInsets.only(top: 100.0),
                                    child: new Material(
                                      borderRadius: BorderRadius.circular(7.0),
                                      elevation: 5.0,
                                      child: new Container(
                                        width: MediaQuery.of(context).size.width - 20.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20.0)),
                                        child: new Form(
                                            key: _formKey,
                                            child: new Container(
                                              padding: EdgeInsets.all(18.0),
                                              child: new Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    height: 70.0,
                                                    width: 300.0,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text('Sign up', style: heading35Black,),
//                                                        Text(' with email and phone number', style: heading35BlackNormal,),
                                                      ],
                                                    ),
                                                  ),
                                                  new Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Row(children: [
                                                        Expanded(child: TextFormField(
                                                            controller: firstnameController,
                                                            keyboardType: TextInputType.text,
                                                            validator: validations.validateFirstName,
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(5.0),
                                                              ),

                                                              contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                                                              hintText: 'First Name',
                                                              hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Quicksand'),

                                                            )
                                                        ),),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 10.0),
                                                        ),
                                                        Expanded(child: TextFormField(
                                                            controller: lastnameController,
                                                            keyboardType: TextInputType.text,
                                                            validator: validations.validateLastName,
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(5.0),
                                                              ),
                                                              contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                                                              hintText: 'Last Name',
                                                              hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Quicksand'),

                                                            )
                                                        ),),
                                                      ],),

                                                      Padding(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                      ),
                                                      TextFormField(
                                                          controller: emailController,
                                                          keyboardType: TextInputType.emailAddress,
                                                          validator: validations.validateEmail,
                                                          decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(5.0),
                                                            ),
                                                            prefixIcon: Icon(Icons.email,
                                                                color: blackColor, size: 20.0),
                                                            contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                                                            hintText: 'Email',
                                                            hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Quicksand'),

                                                          )
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                      ),
                                                      TextFormField(
                                                          controller: phoneController,
                                                          keyboardType: TextInputType.phone,
                                                          validator: validations.validateMobile,
                                                          decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(5.0),
                                                              ),
                                                              prefixIcon: Icon(Icons.phone,
                                                                  color: blackColor, size: 20.0),
                                                              contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                                                              hintText: 'Phone',
                                                              hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Quicksand')
                                                          )
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                      ),
                                                      TextFormField(
                                                          controller: passwordController,
                                                          validator: validations.validatePassword,
                                                          obscureText: true,
                                                          decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(5.0),
                                                              ),
                                                              prefixIcon: Icon(Icons.lock,
                                                                  color: blackColor, size: 20.0),
                                                              contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                                                              hintText: 'Password',
                                                              hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Quicksand')
                                                          )
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                      ),
                                                      Container(

                                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5.0),
                                                            border: Border.all(
                                                                color: Colors.grey,
                                                                width: 1.0
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Expanded(child: Text(
                                                                "Domain :",
                                                                style: TextStyle(fontSize: 16, color: Colors.grey),
                                                              ),),
                                                              DropdownButton<String>(
                                                                value: mDomain,
                                                                elevation: 16,
                                                                style: TextStyle(color: Colors.black, fontSize: 16),
                                                                underline: Container(
                                                                  height: 0,
                                                                  color: Colors.black,
                                                                ),
                                                                onChanged: (String newValue) {
                                                                  setState(() {
                                                                    mDomain = newValue;
                                                                    print(mDomain);
                                                                  });
                                                                },
                                                                items: DOMAINS.map<DropdownMenuItem<String>>((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ],
                                                          )),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                      ),
                                                      Container(

                                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5.0),
                                                            border: Border.all(
                                                                color: Colors.grey,
                                                                width: 1.0
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Expanded(child: Text(
                                                                "CarType :",
                                                                style: TextStyle(fontSize: 16, color: Colors.grey),
                                                              ),),
                                                              DropdownButton<String>(
                                                                value: mCarType,
                                                                elevation: 16,
                                                                style: TextStyle(color: Colors.black, fontSize: 16),
                                                                underline: Container(
                                                                  height: 0,
                                                                  color: Colors.black,
                                                                ),
                                                                onChanged: (String newValue) {
                                                                  setState(() {
                                                                    mCarType = newValue;
                                                                    print(mCarType);
                                                                  });
                                                                },
                                                                items: CAR_TYPES.map<DropdownMenuItem<String>>((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                  new Container(
                                                    padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                                                      child: new Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          InkWell(
                                                            child: new Text("Forgot Password ?",style: textStyleActive,),
                                                          ),
                                                        ],
                                                      )

                                                  ),
                                                  new ButtonTheme(
                                                    height: 50.0,
                                                    minWidth: MediaQuery.of(context).size.width,
                                                    child: RaisedButton.icon(
                                                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                                                      elevation: 0.0,
                                                      color: primaryColor,
                                                      icon: new Text(''),
                                                      label: new Text('SIGN UP', style: headingWhite,),
                                                      onPressed: submit,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                        ),
                                      ),
                                    )
                                ),
                                new Container(
                                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text("Already have an account? ",style: textGrey,),
                                        new InkWell(
                                          onTap: (){Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new LoginScreen()));},
                                          child: new Text("Login",style: textStyleActive,),
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            )
                        )
                    ),
                  ]
                  )
                ]
            ),
          )

      ),
    );
  }
}
