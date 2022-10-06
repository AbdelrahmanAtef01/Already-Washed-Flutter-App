
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/contactingWays.dart';
import 'models/social_user_model.dart';

User? userConst;
SocialUserModel? user;
SocialUserModel? chatUser;
contactingWays? contactingWay;

List<SocialUserModel> users =[];

List<CameraDescription> cameras = [];

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: function(),
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  Function? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit!(),
      onChanged: onChange!(),
      onTap: onTap!(),
      validator: validate!(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed!(),
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false);

void debugPrintFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.0,
      color: Theme.of(context).textTheme.bodyText1!.color,
    );
  }
}

double responsiveValue(BuildContext context, double value) =>
    MediaQuery.of(context).size.width * (value / 375.0);

space3Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 3.0),
);

space4Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 4.0),
);

space5Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 5.0),
);

space8Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 8.0),
);

space10Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 10.0),
);

space16Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 16.0),
);

space20Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 20.0),
);

space30Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 30.0),
);

space40Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 40.0),
);

space50Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 50.0),
);

space60Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 60.0),
);

space70Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 70.0),
);

space80Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 80.0),
);

space90Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 90.0),
);

space100Vertical(BuildContext context) => SizedBox(
  height: responsiveValue(context, 100.0),
);

space3Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 3.0),
);

space4Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 4.0),
);

space5Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 5.0),
);

space8Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 8.0),
);

space10Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 10.0),
);

space15Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 15.0),
);

space20Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 20.0),
);

space30Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 30.0),
);

space40Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 40.0),
);

space50Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 50.0),
);

space60Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 60.0),
);

space70Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 70.0),
);

space80Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 80.0),
);

space90Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 90.0),
);

space100Horizontal(BuildContext context) => SizedBox(
  width: responsiveValue(context, 100.0),
);