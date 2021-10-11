import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/ShopLayout.dart';
import 'package:udemy_flutter_1/Layout/Todo_app/cubit/cubit.dart';
import 'package:udemy_flutter_1/Layout/Todo_app/cubit/states.dart';
import 'package:udemy_flutter_1/Network/local/cache_helper.dart';
import 'package:udemy_flutter_1/components/Companents.dart';
import 'package:udemy_flutter_1/components/constants.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Login/Cubit/Cubit.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Login/Cubit/states.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Register/ShopRegisterScreen.dart';

class ShopLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit , ShopLoginState>(
        listener:(context , state){
          if(state is ShopLoginSuccessState)
          {
            if(state.LoginModel.status == true)
              {
                // print(state.LoginModel.message);
                print(state.LoginModel.data!.token);
                cacheHelper.saveData(key: 'token',
                  value: state.LoginModel.data!.token,).then((value){
                  token = state.LoginModel.data!.token!;

                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) => ShopLayout(),
                  ),
                  (Route<dynamic>route) => false,);

                });
                // showToast(
                //   text: state.LoginModel.message.toString(),
                //   state: ToastStates.SUCCESS,
                // );

              }
            else
                {
                  print(state.LoginModel.message);

                  showToast(
                    text: state.LoginModel.message.toString(),
                    state: ToastStates.WARNING,
                  );

                }
          }
        },
        builder:(context , state) {
          ShopLoginCubit Cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),),
                        Text('login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color:Colors.grey,
                          ),),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextForm(context,
                          controller: EmailController,
                          keyBoardType: TextInputType.emailAddress,
                          text: 'Email address',
                          onTap: (){},
                          preIcon: Icons.email,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextForm(
                          context,
                          Cubit: Cubit,
                          controller: PasswordController,
                          IsPassword: true,
                          keyBoardType: TextInputType.text,
                          text: 'Password',
                          validate: (String? value) {
                            value!.isEmpty ? 'Password is too short' : null;
                          },
                          onTap: () {},
                          preIcon: Icons.lock_open_outlined,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          builder: (BuildContext context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: EmailController.text,
                                    password: PasswordController.text);
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          condition: state is! ShopLoginLoadingState,
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account ?'),
                            TextButton(onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (BuildContext context) => ShopRegisterScreen(),
                                ),
                              );
                            }, child: Text('Register Now')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
