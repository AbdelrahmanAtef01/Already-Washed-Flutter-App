import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constants.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
        builder: (context, state)
      {
        var cubit = AppBloc.get(context);

      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Image.network(
                          'https://img.freepik.com/free-photo/man-holding-pile-clean-clothes_23-2149117026.jpg?w=740&t=st=1658751135~exp=1658751735~hmac=6b872670e1f33c8a93d54f992079e16d9b3d4f3d930d7b4b119f73dde56475bd',
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,)

                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    const Text(
                      'Login to explore',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      cursorColor: Colors.teal,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email address must not be empty';
                        }

                        return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        isDense: false,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        label: const Text(
                          'email address',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      cursorColor: Colors.teal,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password is too short';
                        }

                        return null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        isDense: false,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        border: OutlineInputBorder(
                          //borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        label: const Text(
                          'password',

                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: isVisible,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      height: 42.0,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: MaterialButton(
                        height: 42.0,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              cubit.isClicked = true;
                            });
                            cubit.userLogin(email: emailController.text,
                                password: passwordController.text,
                                context: context);
                          }
                        },
                        child: cubit.isClicked
                            ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        ) : const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                        ),
                        TextButton(
                          onPressed: () {
                            navigateTo(context, const RegisterScreen(),);
                          },
                          child: const Text(
                            'Register',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    );
  }
}