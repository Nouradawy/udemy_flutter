import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/Cubit/Cubit.dart';
import 'package:udemy_flutter_1/Layout/Shop_app/Cubit/states.dart';
import 'package:udemy_flutter_1/components/Companents.dart';
import 'package:udemy_flutter_1/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var namecontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    var phonecontroller = TextEditingController();
    return BlocProvider.value(
      value: ShopCubit.get(context)..postRegisterdData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          // if(state is ShopSuccessUserState)
          //   {
          //     namecontroller.text = state.shopLoginModel.data!.name!;
          //     emailcontroller.text = state.shopLoginModel.data!.email!;
          //     phonecontroller.text = state.shopLoginModel.data!.phone!;
          //
          //   }
        },
        builder: (context, state) {
          var model = ShopCubit.get(context).shopLoginModel;
          if(model!.data !=null) {
            namecontroller.text = model.data!.name!;
            emailcontroller.text = model.data!.email!;
            phonecontroller.text = model.data!.phone!;
          }

          return ConditionalBuilder(
              condition: model.data != null,
              fallback: (context) => Center(child: CircularProgressIndicator()),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(children: [
                    defaultTextForm(
                      context,
                      controller: namecontroller,
                      keyBoardType: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      text: 'Name',
                      preIcon: Icons.person,
                      onTap: () {},
                    ),
                    SizedBox(height: 10),
                    defaultTextForm(
                      context,
                      controller: emailcontroller,
                      keyBoardType: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                      text: 'Email',
                      preIcon: Icons.email,
                      onTap: () {},
                    ),
                    SizedBox(height: 10),
                    defaultTextForm(
                      context,
                      controller: phonecontroller,
                      keyBoardType: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      text: 'Phone',
                      preIcon: Icons.phone,
                      onTap: () {},
                    ),
                    SizedBox(height: 20,),
                    defaultButton(function: (){
                      SignOut(context);
                    }, text: 'logout'),

                  ]),
                );
              });
        },
      ),
    );
  }
}
