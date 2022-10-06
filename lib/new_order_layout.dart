import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maghsala/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'home_layout.dart';

class newOrderLayout extends StatefulWidget {
  const newOrderLayout({Key? key}) : super(key: key);
  @override
  State<newOrderLayout> createState() => _newOrderLayoutState();
}

class _newOrderLayoutState extends State<newOrderLayout> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){
                navigateAndFinish(context,const HomeLayoutScreen(),);
                cubit.closeOrder();
                cubit.changeIndex(index: 0,);},
                icon: const Icon(Icons.arrow_back_ios_new),),
              title: const Text('New Order'),
            ),
            body:SingleChildScrollView(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:10,horizontal: 20,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap:(){
                              setState(() {
                                int lastIndex= cubit.newOrderIndex;
                                cubit.changeIndex(index: 0,lastIndex: lastIndex);

                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                    child: Image.asset('assets/images/Hanger.png'),
                                    height: 40,
                                  width: 40,
                                ),
                                 cubit.firstIcon,
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                      width: 70,
                      height: 1.0,
                      color: cubit.indicitar1Color,
                  ),
                              space10Vertical(context),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                int lastIndex= cubit.newOrderIndex;
                                cubit.changeIndex(index: 1,lastIndex: lastIndex);

                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset('assets/images/map-location.png'),
                                  height: 40,
                                  width: 40,
                                ),
                                cubit.secondIcon,
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                      width: 70,
                      height: 1.0,
                      color: cubit.indicitar2Color,
                  ),
                              space10Vertical(context),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                int lastIndex= cubit.newOrderIndex;
                                cubit.changeIndex(index: 2,lastIndex: lastIndex);

                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset('assets/images/dollar-sign.png'),
                                  height: 40,
                                  width: 40,
                                ),
                                cubit.thirdIcon,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    cubit.newOrder,
                   if(cubit.newOrderIndex == 0)
                     Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         TextButton(onPressed: (){
                           setState(() {
                               cubit.changeIndex(index: 1,lastIndex: 0);
                           });
                         },
                           child:const Text('next... >',
                             style: const TextStyle(
                               fontSize: 18,
                               fontWeight:FontWeight.w600 ,
                             ),) ,),

                       ],
                     ),
                    if(cubit.newOrderIndex == 1 )
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: (){
                            setState(() {
                              cubit.changeIndex(index: 0,lastIndex: 1);

                            });
                          },
                            child:const Text('< previous',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600
                              ),) ,),
                          Spacer(),
                          TextButton(onPressed: (){
                            setState(() {
                              cubit.changeIndex(index: 2,lastIndex: 1);

                            });
                          },
                            child:const Text('next... >',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight:FontWeight.w600 ,
                              ),) ,),
                        ],
                      ),
                    if(cubit.newOrderIndex == 2)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(onPressed: (){
                            setState(() {
                              cubit.changeIndex(index: 1,lastIndex: 2);
                            });
                          },
                            child:const Text('< previous',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600
                              ),) ,),
                        ],
                      ),
                    space20Vertical(context),
    ],
                ),
              ),
            ),
          );
        }
    );
  }

}
