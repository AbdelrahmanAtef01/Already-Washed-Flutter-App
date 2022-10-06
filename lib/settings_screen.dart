import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maghsala/info_screen.dart';
import 'package:maghsala/network/local/cache_helper.dart';
import 'constants.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'home_layout.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  late Icon icon1 ;
  late Icon icon2 ;

  late Widget row;
  TextEditingController passwordUpdateController = TextEditingController();
  bool isVisible = true;

  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = AppBloc.get(context);
          usernameController.text = user!.name! ;
          emailController.text = user!.email! ;
          passwordController.text = user!.password! ;
          phoneController.text = user!.phone! ;
          addressController.text = user!.address ;

          if (user!.whatsappPrivacy == true)
            {   icon1 = const Icon(Icons.radio_button_checked);
             icon2 = const Icon(Icons.radio_button_unchecked);}else{
             icon1 = const Icon(Icons.radio_button_unchecked);
             icon2 = const Icon(Icons.radio_button_checked);
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){navigateAndFinish(context,const HomeLayoutScreen(),);},
                icon: const Icon(Icons.arrow_back_ios_new),),
              title: const Text('Settings'),
            ),
            body:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40.0,
                    ),
                    const Text('Update your data ?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),),
                    const SizedBox(
                      height: 4.0,
                    ),
                    DottedBorder(
                      color: Colors.teal,
                      strokeWidth: 2,
                      dashPattern: [
                        5,
                        5,
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20.0,
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
                              ),
                              obscureText: true,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Address must not be empty';
                                }

                                return null;
                              },
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
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: MaterialButton(
                        onPressed: (){
                          showDialog(context: context,
                            builder: (context) => AlertDialog(
                            title: const Text('Update your data',
                              style: const TextStyle(color: Colors.teal,),),
                            content: Column(
                              children: [
                                const Text('- Please enter your old password :',
                                  style:TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),),
                                space20Vertical(context),
                                TextFormField(
                                  cursorColor: Colors.teal,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'password is too short';
                                    }
                                    return null;
                                  },
                                  controller: passwordUpdateController,
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
                                        setState((){
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
                                space10Vertical(context),
                                if (passwordUpdateController.text == user!.password)
                             Row(
                            children: [
                            const Icon(Icons.check,
                            color: Colors.green,),
                            space5Horizontal(context),
                            const Text('password matched',
                            style: const TextStyle(
                            color: Colors.green,
                            ),),
                            ],
                            )else Row(
                            children: [
                            const Icon(Icons.error_outline,
                            color: Colors.red,),
                            space5Horizontal(context),
                            const Text('password still missing...',
                            style: const TextStyle(
                            color: Colors.red,
                            ),),
                            ],
                            ),
                              ],
                            ),
                            actions: [
                              Center(
                                child: Container(
                                  height: 42.0,
                                  width: 200.0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    color: passwordUpdateController.text == user!.password ?
                                    Colors.teal: Colors.grey,
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                  child: MaterialButton(
                                    height: 42.0,
                                    onPressed: () {
                                      if(passwordUpdateController.text == user!.password) {
                                        cubit.updateAccountData(
                                            userName: usernameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            address: addressController.text,
                                            phoneNumber: phoneController.text);
                                        Fluttertoast.showToast(msg: 'Your account updated succefully :)',
                                            backgroundColor: Colors.green);
                                        passwordUpdateController.clear();
                                        Navigator.pop(context);
                                      }else {
                                        Fluttertoast.showToast(msg: 'Wrong password. please try again',
                                            backgroundColor: Colors.red);
                                      }
                                    },
                                    child:const Text(
                                      'Update account',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  passwordUpdateController.clear();
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                ),
                              ),
                            ],
                          ));
                        },
                        child: const Text(
                          "Update",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DottedBorder(
                      color: Colors.teal,
                      strokeWidth: 2,
                      dashPattern: [
                        5,
                        5,
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            const Text('Dark mode : ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),
                            const SizedBox(
                              width: 150.0,
                            ),
                            IconButton(onPressed: (){cubit.changeAppMode();},
                              icon: const Icon(Icons.brightness_4_rounded,size: 30,),),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DottedBorder(
                      color: Colors.teal,
                      strokeWidth: 2,
                      dashPattern: [
                        5,
                        5,
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('change your privacy : ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const MyDivider(),
                            const SizedBox(
                              height: 15.0,
                            ),
                            InkWell(
                              onTap: (){
                                choosePrivacy1();
                                cubit.updatePrivacy(whatsappPrivacy: true);
                              },
                              child: Row(
                                children: [
                                  icon1,
                                  const SizedBox(width: 30.0,),
                                  const Text('Send offers via whatsapp ',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            InkWell(
                              onTap: (){
                                choosePrivacy2();
                                cubit.updatePrivacy(whatsappPrivacy: false);
                              },
                              child: Row(
                                children: [
                                  icon2,
                                  const SizedBox(width: 30.0,),
                                  const Text('Don\'t send offers via whatsapp ',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: MaterialButton(
                        onPressed: (){
                          CacheHelper.removeData(key: 'UID');
                          navigateAndFinish(
                          context,
                          const LoginScreen(),
                        );
                        },
                        child: const Text(
                          "Log out",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Want to read more about us ?',
                        ),
                        TextButton(
                          onPressed: () {
                            navigateTo(context, const InfoScreen(),);
                          },
                          child: const Text(
                            'click here',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  void choosePrivacy1 (){
    setState((){
      icon1 =  const Icon(Icons.radio_button_checked);
      icon2 = const Icon(Icons.radio_button_unchecked);
    });
  }
  void choosePrivacy2 (){
    setState((){
      icon1 =  const Icon(Icons.radio_button_unchecked);
      icon2 = const Icon(Icons.radio_button_checked);
    });
  }

}