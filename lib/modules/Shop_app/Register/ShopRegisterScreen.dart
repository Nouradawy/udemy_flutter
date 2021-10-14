import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/Cubit/Cubit.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/Cubit/states.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/ShopLayout.dart';
import 'package:udemy_flutter_1/components/Companents.dart';
import 'package:udemy_flutter_1/components/constants.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Login/Cubit/Cubit.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Login/Cubit/states.dart';
import 'package:udemy_flutter_1/Network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();

    var namecontroller = TextEditingController();
    var phonecontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();
    String? Textout;
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Register"),
      ),
      body:BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {
          if (state is ShopSuccessPostRegisterDataState) {
            ShopLoginCubit.get(context).userLogin(
                email: emailcontroller.text,
                password: passwordcontroller.text);
            BlocListener<ShopLoginCubit, ShopLoginState>(
                listener: (context, state) {
                  if (state is ShopLoginSuccessState) {
                    if (state.LoginModel.status == true) {
                      // print(state.LoginModel.message);
                      print('print from state : ' +
                          "${state.LoginModel.data?.token}");
                      cacheHelper.saveData(key: 'token',
                        value: state.LoginModel.data?.token,).then((value) {
                        token = state.LoginModel.data?.token;

                        Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) =>
                              BlocProvider.value(
                                  value:ShopCubit()..getHomeData()..getFavoritesData()..getCategoriesData()..getUserData(),
                                  child: ShopLayout()),
                          ),
                              (Route<dynamic>route) => false,);
                      });
                      // showToast(
                      //   text: state.LoginModel.message.toString(),
                      //   state: ToastStates.SUCCESS,
                      // );

                    }
                    else {
                      print(state.LoginModel.message);

                      showToast(
                        text: state.LoginModel.message.toString(),
                        state: ToastStates.WARNING,
                      );
                    }
                  }
                }
            );
          }
        },
          builder: (context , state)
          {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultTextForm(
                        context,
                        controller: namecontroller,
                        keyBoardType: TextInputType.text,
                        text: 'name',
                        onTap: (){},
                        validate: (String? value){
                          value!.isEmpty? "Name must not be Empty": null;
                        },
                        preIcon: Icons.person,
                      ),
                      SizedBox(height: 15,),
                      defaultTextForm(
                        context,
                        controller: phonecontroller,
                        keyBoardType: TextInputType.phone,
                        text: 'Phone nummber',
                        onTap: (){},
                        validate: (String? value){
                          value!.isEmpty? "Phone must not be Empty": null;
                        },
                        preIcon: Icons.phone,
                      ),SizedBox(height: 15,),
                      defaultTextForm(
                        context,
                        controller: emailcontroller,
                        keyBoardType: TextInputType.emailAddress,
                        text: 'emailAddress',
                        onTap: (){},
                        validate: (String? value){
                          value!.isEmpty? "emailAddress must not be Empty": null;
                        },
                        preIcon: Icons.email,
                      ),SizedBox(height: 15,),
                      defaultTextForm(
                        context,
                        Cubit: ShopCubit.get(context),
                        controller: passwordcontroller,
                        keyBoardType: TextInputType.text,
                        IsPassword: true,
                        text: 'Password',
                        onTap: (){},
                        validate: (String? value) =>value!.isEmpty? "Password must not be Empty": null,
                        preIcon: Icons.vpn_key,
                      ),
                      SizedBox(height: 25,),
                      ConditionalBuilder(
                        condition: state is!ShopLoadingPostRegisterDataState,
                        fallback: (context){
                          return Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              Text(ShopCubit.get(context).Textout!),
                            ],
                          ),
                        );
                        },

                        builder: (BuildContext context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).postRegisterdData(
                                  name: namecontroller.text,
                                  phone: phonecontroller.text,
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                            }
                          },
                          text: 'Submit',
                          isUpperCase: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }, )
    );
  }
}
