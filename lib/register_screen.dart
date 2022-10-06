import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = true;


  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {},
    builder: (context, state) {
      var cubit = AppBloc.get(context);
      return Scaffold(
      appBar: AppBar(
        title: const Text(
          'REGISTER',
        ),
      ),
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
                      child:Image.network('https://img.freepik.com/free-photo/man-holding-pile-clean-clothes_23-2149117026.jpg?w=740&t=st=1658751135~exp=1658751735~hmac=6b872670e1f33c8a93d54f992079e16d9b3d4f3d930d7b4b119f73dde56475bd',width: MediaQuery.of(context).size.width,)

                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  const Text(
                    'Register now and discover app',
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
                        return 'username must not be empty';
                      }

                      return null;
                    },
                    controller: usernameController,
                    keyboardType: TextInputType.name,
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
                        'username',
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
                    height: 20.0,
                  ),
                  TextFormField(
                    cursorColor: Colors.teal,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone number must not be empty';
                      }

                      return null;
                    },
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
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
                        'phone',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    cursorColor: Colors.teal,
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,
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
                        'Address',
                      ),
                    ),
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
                          cubit.userRegister(
                              name: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                              context: context);
                          userConst = FirebaseAuth.instance.currentUser;
                        }
                          },
/*                            FirebaseMessaging.instance.getToken().then((value) {
                              UserDataModel model = UserDataModel(
                                uId: userData.user!.uid,
                                image: '',
                                email: emailController.text,
                                username: usernameController.text,
                                token: value!,
                              );
                                userConst = userData.user;*/
                      child: cubit.isClicked
                    ? const CupertinoActivityIndicator(
                    color: Colors.white,
                    ) : const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    });
  }
}

