import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maghsala/info_screen.dart';
import 'package:maghsala/models/member_ship_model.dart';
import 'package:maghsala/models/user_member_ship_model.dart';
import 'package:maghsala/network/local/cache_helper.dart';
import 'contact_screen.dart';
import 'constants.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'member_ship_screen.dart';
import 'new_order_layout.dart';
import 'settings_screen.dart';
import 'track_order.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {

  var timer;

  @override
  void initState() {
    super.initState();
    userConst = FirebaseAuth.instance.currentUser;
    //AppBloc.get(context).getUserData(userConst!.uid);
    AppBloc.get(context).getMessages();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      AppBloc.get(context).endSubscription();
    },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppBloc.get(context);
          return Scaffold(
              appBar: AppBar(
                actions: [
                  Stack(
                    children: [
                      IconButton(onPressed: (){navigateTo(context, const contactScreen(),);
                      print(CacheHelper.getData(key: 'messagesLength'));
                      print(AppBloc.get(context).messagesList.length);},
                        icon: const Icon(Icons.chat_outlined),color: Colors.black,),
                      if(CacheHelper.getData(key: 'messagesLength') != null && CacheHelper.getData(key: 'messagesLength') < cubit.messagesList.length)
                       Positioned(
                        top: 4,
                        right: 5,
                        child: Icon(Icons.circle,
                          color: Colors.red,
                          size: 20,),
                      ),
                    ],
                  )
                ],
                title: const Text('Already washed', style: const TextStyle(color: Colors.black),),
              ),
              body: Container(
                color: Colors.teal,
                child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Image(
                            fit: BoxFit.fill,
                            height: 300.0,
                            width: double.infinity,
                            image: NetworkImage('https://img.freepik.com/free-vector/housework-icons-collection_1234-29.jpg?w=740&t=st=1659117078~exp=1659117678~hmac=8a5a65af51cfaa9929426ff62e179cca24a29e3066f54af36987257dbd01ecf5')
                        ),

                      ),
                      const SizedBox(height: 20.0,),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child:MyDivider(),),
                      const Text('Clean Outfit Services',
                        style:TextStyle(fontSize: 30.0,
                          fontWeight:FontWeight.bold,
                          color: Colors.black,
                        ),),
                      const Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child:const MyDivider(),),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    cubit.getSubscription();
                                    cubit.getPromoCodes();
                                    cubit.sendNotification(title: 'test1', body: 'Hello from master');
                                    if(CacheHelper.getData(key: 'isSubscribed') == true) {
                                      navigateTo(context, const newOrderLayout());
                                    }else {
                                      showDialog(context: context,
                                          builder: (context) =>
                                              AlertDialog(
                                                title: const Text(
                                                  'Update your data',
                                                  style: TextStyle(
                                                    color: Colors.teal,),),
                                                content: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.error_outline,
                                                          color: Colors
                                                              .yellow,),
                                                        space5Horizontal(
                                                            context),
                                                        const Expanded(
                                                          child: Text(
                                                            'you\'re not subscribed to any of our member ships',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .yellow,
                                                            ),),
                                                        ),
                                                      ],
                                                    ),
                                                    space30Vertical(context),
                                                    const Text(
                                                        'you can subscribe to many memberships weekly ,monthly and even annually'),
                                                    space30Vertical(context),
                                                    Container(
                                                      height: 42.0,
                                                      width: 200.0,
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      decoration: BoxDecoration(
                                                        color: Colors.teal,
                                                        borderRadius: BorderRadius
                                                            .circular(
                                                          10.0,
                                                        ),
                                                      ),
                                                      child: MaterialButton(
                                                        height: 42.0,
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                          navigateTo(context,
                                                              const MemberShipScreen());
                                                        },
                                                        child: const Text(
                                                          'Go to memberships',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    space30Vertical(context),
                                                    RichText(
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
                                                    text: 'you can make an order without being subscribed to any membership and pay on delivery ,wants to know more ? '),
                                                TextSpan(
                                                    text: 'Click here',
                                                    style: const TextStyle(color: Colors.teal),
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        navigateTo(context, const InfoScreen());
                                                      }),
                                              ],
                                            ),
                                          ),
                                                    space20Vertical(context),
                                                    Container(
                                                      height: 42.0,
                                                      width: 200.0,
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      decoration: BoxDecoration(
                                                        color: Colors.teal,
                                                        borderRadius: BorderRadius
                                                            .circular(
                                                          10.0,
                                                        ),
                                                      ),
                                                      child: MaterialButton(
                                                        height: 42.0,
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                          navigateTo(context,
                                                              const newOrderLayout());
                                                        },
                                                        child: const Text(
                                                          'make an order',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'Cancel',
                                                    ),
                                                  ),
                                                ],
                                              ));
                                    }
                                  },
                                  child: Container(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.request_page_outlined,color: Colors.black,),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text(
                                          'New order',
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                      color: Colors.teal[200],
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black87, //New
                                            blurRadius: 25.0,
                                            offset: Offset(0, 10))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    navigateTo(context, const trackOrderScreen(),);
                                  },
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.cached,color: Colors.black,),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text(
                                          'Tracking order',
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black87, //New
                                            blurRadius: 25.0,
                                            offset: Offset(0, 10))
                                      ],
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                      color: Colors.teal[200],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    navigateTo(context, const MemberShipScreen(),);
                                  },
                                  child:Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.subscriptions_rounded,color: Colors.black,),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text(
                                          'Membership',
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black87, //New
                                            blurRadius: 25.0,
                                            offset: Offset(0, 10))
                                      ],
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                      color: Colors.teal[200],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    navigateTo(context, const SettingsScreen(),);
                                  },
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.settings,color: Colors.black,),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text(
                                          'Settings',
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                      color: Colors.teal[200],
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black87, //New
                                            blurRadius: 25.0,
                                            offset: Offset(0, 10))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              )
          );
        });
  }
}


class SplashscreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator SplashscreenWidget - FRAME
    return Container(
        width: 414,
        height: 896,
        decoration: BoxDecoration(
          boxShadow : [BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.11999999731779099),
              offset: Offset(20,20),
              blurRadius: 50
          )],
          gradient : LinearGradient(
              begin: Alignment(0.16078464686870575,0.8199184536933899),
              end: Alignment(-0.8199184536933899,0.7531126141548157),
              colors: [Color.fromRGBO(44, 184, 171, 1),Color.fromRGBO(35, 170, 157, 1)]
          ),
        ),
        child: Stack(
            children: [
              Positioned(
                  top: 861.985107421875,
                  left: 147,
                  child: Container(
                      width: 124,
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17),
                          bottomLeft: Radius.circular(17),
                          bottomRight: Radius.circular(17),
                        ),
                        color : Color.fromRGBO(255, 255, 255, 1),
                      )
                  )
              ),Positioned(
                  top: 389,
                  left: 89,
                  child: Container(
                      width: 236,
                      height: 118,
                      decoration: BoxDecoration(
                        image : DecorationImage(
                            image: AssetImage('assets/images/Ab_already202445451.png'),
                            fit: BoxFit.fitWidth
                        ),
                      )
                  )
              ),Positioned(
                  top: 756.637451171875,
                  left: 180.86245727539062,
                  child: Container(
                      width: 39,
                      height: 39,
                      decoration: BoxDecoration(
                        color : Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 3.6192333698272705,
                                left: 3.25,
                                child: Image.asset(
                                    'assets/images/vector.svg',
                                    //semanticsLabel: 'vector'
                                ),
                            ),
                          ]
                      )
                  )
              ),
            ]
        )
    );
  }
}
