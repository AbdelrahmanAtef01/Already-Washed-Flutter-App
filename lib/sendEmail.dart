import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maghsala/contact_screen.dart';
import 'package:maghsala/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class sendEmail extends StatefulWidget {
  const sendEmail({Key? key}) : super(key: key);
  @override
  State<sendEmail> createState() => _sendEmailState();
}

class _sendEmailState extends State<sendEmail> {

  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(icon:Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () { navigateAndFinish(context, contactScreen(),); },),
              title: Text('Send email'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  const SizedBox(height: 15,),
                  Row(children: [
                    Text('Subject'),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: TextFormField(
                        cursorColor: Colors.teal,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Subject must not be empty';
                          }

                          return null;
                        },
                        controller: subjectController,
                        keyboardType: TextInputType.text,
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
                            'Subject',
                          ),
                        ),
                      ),
                    ),
                  ],),
                  const SizedBox(height: 15,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Body'),
                    const SizedBox(width: 22,),
                    Expanded(
                      child: TextFormField(
                        maxLines: 20,
                        cursorColor: Colors.teal,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Body must not be empty';
                          }

                          return null;
                        },
                        controller: bodyController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: '\nwe are pleased to hear from you :)\n'
                              'write your problem or suggestion here ...',
                          isDense: false,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],),
                  const SizedBox(height: 30,),
                  Container(
                    width: double.infinity,
                    height: 50.0,
                    child: MaterialButton(
                      onPressed: (){
                        cubit.sendingEmail(
                            subject: subjectController.text,
                            body: bodyController.text);
                        navigateAndFinish(context, contactScreen());
                      },
                      child: Text(
                        "Send Email",
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
                ],),
              ),
            ),
          );
        }
    );
  }
}