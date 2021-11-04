// import 'dart:js';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_flutter_1/Layout/Todo_app/cubit/cubit.dart';
import 'package:udemy_flutter_1/components/constants.dart';
import 'package:udemy_flutter_1/modules/News_app/SettingsScreen/WebViewScreen.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Login/Cubit/Cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required Function() function,
  required String text,
  bool isUpperCase = true,
  double radius = 3.0,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
    );



Widget defaultTextForm(
  context, {
  required TextEditingController controller,
  required TextInputType keyBoardType,
  required String text,
  required Function() onTap,
  Function(String?)? onChang,
  bool IsPassword = false,
  // bool ObsText = false
  String? Function(String?)? validate,
  IconData? preIcon,
  IconData? SuffixIcon,
  bool AutoFocus = false,
  String? prefixText,
      var Cubit,
}) {
  final bool isactive = IsPassword;
  isactive?IsPassword = Cubit.isPassword: null;

  return TextFormField(
    controller: controller,
    autofocus: AutoFocus,
    obscureText: IsPassword,
    keyboardType: keyBoardType,
    validator: validate,
    onTap: onTap,
    onChanged: onChang,
    decoration: InputDecoration(
      prefixText: prefixText,
      labelText: text,
      prefixIcon: Icon(
        preIcon,
      ),
      suffixIcon: isactive
           ?IconButton(
              onPressed: () {

                Cubit.Passon();
              },
              icon: Icon(Cubit.suffixIcon),
            )
          : IconButton(
              onPressed: () {},
              icon: Icon(SuffixIcon),
            ),
      border: OutlineInputBorder(),
    ),
  );
}

Widget buildTaskItem(
  Map model,
  context,
) =>
    Dismissible(
      key: Key(model['id'].toString()),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircleAvatar(
              radius: 38.0,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 36.0,
                backgroundColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    '${model['time']}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'done',
                  id: model['id'],
                );
              },
              icon: Icon(Icons.check_box)),
          IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'archive',
                  id: model['id'],
                );
              },
              icon: Icon(Icons.archive)),
          // IconButton(onPressed: ()
          // {
          //   AppCubit.get(context).DeleteFromData(id:model['id']);
          // }, icon: Icon(Icons.delete_forever_outlined)),
        ],
      ),
      onDismissed: (direction) {
        AppCubit.get(context).DeleteFromData(id: model['id']);
      },
    );

Widget buildArticleItem(article, context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          WebViewScreeen(article['url'])));
            },
            child: Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
Widget articleBuilder(list, context) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );


void showToast({
  required String text,
  required ToastStates state,})=>
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );

enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
          break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}