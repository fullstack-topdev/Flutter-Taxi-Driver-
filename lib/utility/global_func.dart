




import 'package:flutter/material.dart';
import 'package:flutter_taxi_user/theme/style.dart';
import 'package:fluttertoast/fluttertoast.dart';

AlertDialog mAlertDialog;

void showLoading(BuildContext context){
  showProgressDialog(context, "processing...");

}


void hideDialog(BuildContext context){
  if (mAlertDialog != null){
    mAlertDialog = null;
    Navigator.of(context).pop();
  }
}


void showToast(String text){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,

  );
}

void showProgressDialog(BuildContext context, String title) {
  try {
    mAlertDialog = AlertDialog(
      content: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          CircularProgressIndicator(backgroundColor: primaryColor,valueColor: AlwaysStoppedAnimation<Color>(secondary),),
          Padding(padding: EdgeInsets.only(left: 15),),
          Flexible(
              flex: 8,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return mAlertDialog;
        });
  } catch (e) {
    print(e.toString());
  }
}





