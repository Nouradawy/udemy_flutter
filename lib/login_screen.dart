import 'dart:ui';

import 'package:flutter/material.dart';

import 'components/Companents.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  // var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Messenger',),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          // key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value)
                {
                  if(value!.isEmpty)
                    {
                      return 'email address must not be empty';
                    }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  border: OutlineInputBorder(),

                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              defaultTextForm(
                context,
                onTap: (){},
                validate: (value)
                {
                  if(value!.isEmpty)
                  {
                return 'Password can\'t be empty';
                  }
                  return null;
                    },
                // suffix: (){
                //   setState(() {
                //
                //   });
                //
                //   if (isPassword == true ? isPassword = false : isPassword = true);
                // },
                  controller: passwordController,
                  keyBoardType: TextInputType.visiblePassword,
                  text: 'PASSWORD',
                IsPassword: isPassword,
              ),

              SizedBox(
                height: 15.0,
              ),

              // DefaultButton(
              //   text: 'LOGIN',
              //   background: Colors.blue,
              //   function: ()
              //   {
              //     if (formKey.currentState!.validate())
              //     {
              //       print('email:${emailController.text}');
              //       print(passwordController.text);
              //     }
              //   },
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have account ?',
                  ),
                  TextButton(onPressed: (){},
                    child: Text(
                      'Rwgister Now'
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
