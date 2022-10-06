import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'home_layout.dart';

class trackOrderScreen extends StatefulWidget {
  const trackOrderScreen({Key? key}) : super(key: key);

  @override
  State<trackOrderScreen> createState() => _trackOrderScreenState();
}

class _trackOrderScreenState extends State<trackOrderScreen> {

  var orderNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppBloc.get(context);
          orderNoController.text = cubit.orderNumber.toString();

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(icon:const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () { navigateAndFinish(context, const HomeLayoutScreen(),);},),
              title: const Text('Track order'),
            ),
            body: Column(
              children: [
                space20Vertical(context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          cursorColor: Colors.teal,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'order No must not be empty';
                            }
                            return null;
                          },
                          controller: orderNoController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: const Text('order No'),
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
                      space10Horizontal(context),
                      Container(
                        width: 100,
                        height: 50.0,
                        child: MaterialButton(
                          onPressed: (){

                          },
                          child: const Text(
                            "Apply",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}