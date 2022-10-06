import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maghsala/models/notification_model.dart';
import 'package:maghsala/network/remote/dio_helper.dart';
import '../models/order_model.dart';
import '../models/promo_code.dart';
import '../track_order.dart';
import '/models/contactingWays.dart';
import '/models/user_member_ship_model.dart';
import '/no_of_pieces_screen.dart';
import '/purchase_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import '../home_layout.dart';
import '../models/subscription_model.dart';
import '../pickingup_screen.dart';
import '../main.dart';
import '../models/message_model.dart';
import '../models/social_user_model.dart';
import '../network/local/cache_helper.dart';
import 'state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AppBloc extends Cubit<AppState> {
  AppBloc() : super(AppInitialState());
  static AppBloc get(context) => BlocProvider.of(context);

  bool isClicked = false;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
    required context,
  }) {
    emit(SocialRegisterLoadingState());
    user = null ;
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      CacheHelper.saveData(key: 'UID', value: userConst!.uid);
      userCreate(
        uId: value.user!.uid,
        phone: phone,
        email: email,
        name: name,
        address: address,
        password: password,
        context: context,
      );
      FirebaseAuth.instance.currentUser!
          .sendEmailVerification()
          .then((value) {print('hello');})
          .catchError((error){print('error :$error');});
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uId,
    required String address,
    bool? whatsappPrivacy,
    required context ,
  }) {
      user = SocialUserModel(
      address: address,
      name: name,
      password: password,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
          whatsappPrivacy: true,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(user!.toMap())
        .then((value)
    {
      emit(SocialCreateUserSuccessState());

        isClicked = false;
        getMemberShips();
      navigateAndFinish(context, const HomeLayoutScreen(),);
    })
        .catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));

        isClicked = false;
      Fluttertoast.showToast(
        msg: error
            .toString()
            .split(']')
            .last,
      );
    });
  }


void userLogin({
    required String email,
    required String password,
    required context,
}){
    user = null;
  FirebaseAuth.instance
      .signInWithEmailAndPassword(
      email: email,
      password: password)
      .then((value) {
      isClicked = false;
      userConst = FirebaseAuth.instance.currentUser;
      CacheHelper.saveData(key: 'UID', value: userConst!.uid);
    navigateAndFinish(
      context, const HomeLayoutScreen(),);
  })
      .catchError((error) {

      isClicked = false;

    Fluttertoast.showToast(
      msg: error
          .toString()
          .split(']')
          .last,
    );
  });
}

  void getUserDataWithoutLogin({String? uid}){
    if(uid != null)
      {
        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get().then((value) {
          user = SocialUserModel.fromJson(value.data()!);
          getUserMemberShips();
          // emit(GetUserSuccess());
        }).then((value) {
          FirebaseAuth.instance
              .signInWithEmailAndPassword(
              email: user!.email!,
              password: user!.password!);
        }).catchError((error) {
          debugPrint(error.toString());

          /*   emit(GetUserError(
        message: error.toString(),
      ));*/
        });
      }
  }

  void getUserData(String id) {
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      user = SocialUserModel.fromJson(value.data()!);
      getUserMemberShips();
     // emit(GetUserSuccess());
    }).catchError((error) {
      debugPrint(error.toString());

   /*   emit(GetUserError(
        message: error.toString(),
      ));*/
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if (fromShared == null) {
     isDark = !isDark;
    } else {
      isDark = fromShared ;
    }

      MyApp.themeNotifier.value =
          isDark
          ? ThemeMode.dark
          : ThemeMode.light;
    CacheHelper.saveData(key: 'isDark', value: isDark);

  }

  void updateAccountData({
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
    required String address,
  }){
   user!.name = userName;
   user!.email = email;
   user!.password = password;
   user!.phone = phoneNumber;
   user!.address = address;

   FirebaseAuth.instance.currentUser!.updateEmail(email);
   FirebaseAuth.instance.currentUser!.updatePassword(password);

   FirebaseFirestore.instance
       .collection('users')
       .doc(user!.uId)
       .set(user!.toMap());
}

  void updatePrivacy ({required bool whatsappPrivacy})
  {
    user!.whatsappPrivacy= whatsappPrivacy;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .set(user!.toMap())
        .then((value) {
          Fluttertoast.showToast(msg: 'whatsapp privacy updated successfully',
              backgroundColor: Colors.green);
    })
        .catchError((error){
      Fluttertoast.showToast(msg: 'something went wrong',
          backgroundColor: Colors.red);
    });
  }

  void getContactingWays(){
    FirebaseFirestore.instance
        .collection('contactingWithUs')
        .doc('contactingWays')
        .get().then((value) {
      contactingWay = contactingWays.fromJson(value.data()!);
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void makingPhoneCall() async {
    getContactingWays();
    String? phone = contactingWay!.phoneNumber;
    var url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

 void sendingEmail({required String subject,required String body}) async {
    getContactingWays();
    String? email = contactingWay!.email;
    final Email sendEmail = Email(
      cc: [],
      bcc: [],
      attachmentPaths: [],
      body: body,
      subject: subject,
      recipients: [email!,],
      isHTML: false,
    );
    await FlutterEmailSender.send(sendEmail)
        .then((value) {
    })
        .catchError((error){print('Error sending email : $error');});
  }

  List<SocialUserModel> usersList = [];

  void getUsers() {
    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      usersList = [];

      for (var element in value.docs) {
        if (SocialUserModel.fromJson(element.data()).uId != contactingWay!.receiverId) {
          usersList.add(SocialUserModel.fromJson(element.data()));
        }
      }

      debugPrint(usersList.length.toString());

     // emit(GetUsersSuccess());
    });
  }

  late List<userMemberShipModel> memberShipList = [];
  List<userMemberShipModel> weeklyMemberShipList = [];
  List<userMemberShipModel> monthlyMemberShipList = [];
  List<userMemberShipModel> annuallyMemberShipList = [];

  int weeklyMembershipLength = 0;
  int monthlyMembershipLength = 0;
  int annuallyMembershipLength = 0;

  void getMemberShips() {

    FirebaseFirestore.instance
        .collection('membershipSubscriptions')
        .snapshots().listen((value) {
      memberShipList = [];
      weeklyMemberShipList = [];
      monthlyMemberShipList = [];
      annuallyMemberShipList = [];

      weeklyMembershipLength = 0;
      monthlyMembershipLength = 0;
      annuallyMembershipLength = 0;
      for (var element in value.docs) {
        userMemberShipModel k = userMemberShipModel.fromJson(element.data());
        memberShipList.add(userMemberShipModel.fromJson(element.data()));
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uId)
            .collection('memberShipModels')
            .add(k.toMap());
        if (userMemberShipModel
            .fromJson(element.data())
            .type == 'weekly') {
          weeklyMembershipLength++;
          weeklyMemberShipList.add(userMemberShipModel.fromJson(element.data()));
        }
        if (userMemberShipModel
            .fromJson(element.data())
            .type == 'monthly') {
          monthlyMembershipLength++;
          monthlyMemberShipList.add(userMemberShipModel.fromJson(element.data()));
        }
        if (userMemberShipModel
            .fromJson(element.data())
            .type == 'annually') {
          annuallyMembershipLength++;
          annuallyMemberShipList.add(userMemberShipModel.fromJson(element.data()));
        }
      }
      debugPrint(memberShipList.length.toString());

    });
  }

  void getUserMemberShips() {

    memberShipList = [];
    weeklyMemberShipList = [];
    monthlyMemberShipList = [];
    annuallyMemberShipList = [];

    weeklyMembershipLength = 0;
    monthlyMembershipLength = 0;
    annuallyMembershipLength = 0;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('memberShipModels')
        .snapshots().listen((value) {

      for (var element in value.docs) {
        memberShipList.add(userMemberShipModel.fromJson(element.data()));

        if (userMemberShipModel
            .fromJson(element.data())
            .type == 'weekly') {
          weeklyMembershipLength++;
          weeklyMemberShipList.add(userMemberShipModel.fromJson(element.data()));
        }
        if (userMemberShipModel
            .fromJson(element.data())
            .type == 'monthly') {
          monthlyMembershipLength++;
          monthlyMemberShipList.add(userMemberShipModel.fromJson(element.data()));
        }
        if (userMemberShipModel
            .fromJson(element.data())
            .type == 'annually') {
          annuallyMembershipLength++;
          annuallyMemberShipList.add(userMemberShipModel.fromJson(element.data()));
        }
      }
    });
  }

  TextEditingController messageController = TextEditingController();

  void sendMessage() {
      getContactingWays();
      MessageDataModel model;
      if (messageController.text != '') {
        if (user!.uId == contactingWay!.receiverId) {
          model = MessageDataModel(
            time: DateTime.now().toString(),
            message: messageController.text,
            receiverId: chatUser!.uId,
            senderId: contactingWay!.receiverId,
          );
          FirebaseFirestore.instance
              .collection('users')
              .doc(chatUser!.uId)
              .collection('messages')
              .add(model.toJson())
              .then((value) {
            messageController.clear();
          }).catchError((error) {
            debugPrint(error.toString());

            /*         emit(CreateChatError(
            message: error.toString(),
          ));*/
          });

          FirebaseFirestore.instance
              .collection('users')
              .doc(contactingWay!.receiverId)
              .collection('usersList')
              .doc(chatUser!.uId)
              .collection('messages')
              .add(model.toJson())
              .then((value) {
            messageController.clear();
          }).catchError((error) {
            debugPrint(error.toString());

/*          emit(CreateChatError(
            message: error.toString(),
          ));*/
          });
        } else {
          model = MessageDataModel(
            time: DateTime.now().toString(),
            message: messageController.text,
            receiverId: contactingWay!.receiverId,
            senderId: user!.uId,
          );
          FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uId)
              .collection('messages')
              .add(model.toJson())
              .then((value) {
            messageController.clear();
          }).catchError((error) {
            debugPrint(error.toString());

            /*         emit(CreateChatError(
            message: error.toString(),
          ));*/
          });

          FirebaseFirestore.instance
              .collection('users')
              .doc(contactingWay!.receiverId)
              .collection('usersList')
              .doc(user!.uId)
              .collection('messages')
              .add(model.toJson())
              .then((value) {
            messageController.clear();
          }).catchError((error) {
            debugPrint(error.toString());

/*          emit(CreateChatError(
            message: error.toString(),
          ));*/
          });
        }
      }
  }

  List<MessageDataModel> messagesList = [];

  void getMessagesNotification(){
    CacheHelper.saveData(key: 'messagesLength', value: messagesList.length);
  }

  void getMessages() {

    if (user!.uId == contactingWay!.receiverId) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uId)
          .collection('usersList')
          .doc(chatUser?.uId)
          .collection('messages')
          .orderBy('time', descending: true,)
          .snapshots()
          .listen((value) {
        messagesList = [];

        for (var element in value.docs.reversed) {
          messagesList.add(MessageDataModel.fromJson(element.data()));
        }

        debugPrint(messagesList.length.toString());

        // emit(GetMessagesSuccess());
      });

    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uId)
          .collection('messages').
      orderBy('time', descending: true,)
          .snapshots()
          .listen((value) {
        messagesList = [];

        for (var element in value.docs.reversed) {
          messagesList.add(MessageDataModel.fromJson(element.data()));
        }

        debugPrint(messagesList.length.toString());

        // emit(GetMessagesSuccess());
      });
    }
  }

  void deleteMessages()
  {

    if (user!.uId == contactingWay!.receiverId) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uId)
          .collection('usersList')
          .doc(chatUser?.uId)
          .collection('messages').
      orderBy('time', descending: true,)
          .snapshots()
          .listen((value)
          {
            value.docs.forEach((element) {
              element.reference.delete();
            });

          }).cancel();

    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uId)
          .collection('messages').
      orderBy('time', descending: true,)
          .snapshots()
          .listen((value) {
        value.docs.forEach((element) {
          element.reference.delete();
        });
      }).cancel();
    }
  }

  int newOrderIndex = 0;

  Widget newOrder = const noOfPiecesScreen();

    List<Widget> newOrders =
    [
      const noOfPiecesScreen(),
      const pickingUpScreen(),
      const purchaseScreen(),
    ];


  late Icon firstIcon = const Icon(Icons.radio_button_checked,
    color: Colors.teal,);
  late Icon secondIcon = const Icon(Icons.radio_button_unchecked,
    color: Colors.grey,);
  late Icon thirdIcon = const Icon(Icons.radio_button_unchecked,
    color: Colors.grey,);
  late Color indicitar1Color = Colors.grey;
  late Color indicitar2Color = Colors.grey;

  orderModel order = orderModel();
  var washingNumberController = TextEditingController();
  var drycleaningNumberController = TextEditingController();
  var ironNumberController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var timeController1 = TextEditingController();
  var dateController1 = TextEditingController();
  var addressController = TextEditingController();
  var promocodeController = TextEditingController();

  void changeIndex ({required int index, int? lastIndex}){
    if (index == 0){
      newOrderIndex = 0;
      indicitar1Color = Colors.grey;
      indicitar2Color= Colors.grey;
      firstIcon = const Icon(Icons.radio_button_checked,
      color: Colors.teal,);
      secondIcon = const Icon(Icons.radio_button_unchecked,
        color: Colors.grey,);
      thirdIcon = const Icon(Icons.radio_button_unchecked,
        color: Colors.grey,);
      newOrder = newOrders[0];
    }else if(index == 1){
      if (lastIndex == 2 || noOfPiecesFormKey.currentState!.validate()) {
        CacheHelper.saveData(key: 'y', value: true);
        index=1;
        newOrderIndex=1;
        indicitar1Color = Colors.teal;
      indicitar2Color= Colors.grey;
      firstIcon = const Icon(Icons.radio_button_checked,
        color: Colors.teal,);
      secondIcon = const Icon(Icons.radio_button_checked,
        color: Colors.teal,);
      thirdIcon = const Icon(Icons.radio_button_unchecked,
        color: Colors.grey,);
      newOrder = newOrders[1];
      }else{
        CacheHelper.saveData(key: 'y', value: false);
        index=0;
        newOrderIndex=0;
        indicitar1Color = Colors.grey;
        indicitar2Color= Colors.grey;
        firstIcon = const Icon(Icons.radio_button_checked,
          color: Colors.teal,);
        secondIcon = const Icon(Icons.radio_button_unchecked,
          color: Colors.grey,);
        thirdIcon = const Icon(Icons.radio_button_unchecked,
          color: Colors.grey,);
        newOrder = newOrders[0];
      }
    }else if(index == 2) {
      if (lastIndex == 1){
        if(pickingUpFormKey.currentState!.validate()) {
          index = 2;
          newOrderIndex = 2;
          indicitar1Color = Colors.teal;
          indicitar2Color = Colors.teal;
          firstIcon = const Icon(Icons.radio_button_checked,
        color: Colors.teal,);
          secondIcon = const Icon(Icons.radio_button_checked,
        color: Colors.teal,);
          thirdIcon = const Icon(Icons.radio_button_checked,
        color: Colors.teal,);
          newOrder = newOrders[2];
    }else{
          index=1;
          newOrderIndex=1;
          indicitar1Color = Colors.teal;
          indicitar2Color= Colors.grey;
          firstIcon = const Icon(Icons.radio_button_checked,
            color: Colors.teal,);
          secondIcon = const Icon(Icons.radio_button_checked,
            color: Colors.teal,);
          thirdIcon = const Icon(Icons.radio_button_unchecked,
            color: Colors.grey,);
          newOrder = newOrders[1];
        }
        }else if(lastIndex == 0 && noOfPiecesFormKey.currentState!.validate()){
         if(CacheHelper.getData(key:'y') == true){
           index = 2;
           newOrderIndex = 2;
           indicitar1Color = Colors.teal;
           indicitar2Color = Colors.teal;
           firstIcon = const Icon(Icons.radio_button_checked,
             color: Colors.teal,);
           secondIcon = const Icon(Icons.radio_button_checked,
             color: Colors.teal,);
           thirdIcon = const Icon(Icons.radio_button_checked,
             color: Colors.teal,);
           newOrder = newOrders[2];
         }else {
           index = 0;
           newOrderIndex = 0;
           indicitar1Color = Colors.grey;
           indicitar2Color = Colors.grey;
           firstIcon = const Icon(Icons.radio_button_checked,
             color: Colors.teal,);
           secondIcon = const Icon(Icons.radio_button_unchecked,
             color: Colors.grey,);
           thirdIcon = const Icon(Icons.radio_button_unchecked,
             color: Colors.grey,);
           newOrder = newOrders[0];
         }
        }
    }
}

  DateTime startingDate = DateTime.now();
  DateTime? endDate;
  bool cacheIsSubscribed = false;
  subscriptionModel? subscription;

  void setSubscription({required int i ,required name,}) {
    userMemberShipModel m = memberShipList.firstWhere((element) => element.name == name);
    subscription = null;
    if (i == 1)
    {endDate = DateTime(startingDate.year, startingDate.month, startingDate.day + 7,startingDate.hour);}
    else if(i==2)
    {endDate = DateTime(startingDate.year, startingDate.month + 1, startingDate.day,startingDate.hour);}
    else if(i == 3)
    {endDate = DateTime(startingDate.year + 1, startingDate.month, startingDate.day,startingDate.hour);}
    
    subscription = subscriptionModel(
        startingDate: startingDate.toString(),
        endDate: endDate.toString(),
        name: m.name,
        noOfOrders: m.noOfOrders!,
        noOfWash: m.noOfWash,
        noOfDryClean: m.noOfDryClean,
        noOfIron: m.noOfIron,
        isPaid: false);
    
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('subscription')
        .add(subscription!.toMap())
        .then((value) {
         cacheIsSubscribed = true;
         CacheHelper.saveData(key: 'isSubscribed', value: cacheIsSubscribed);
          m.isSubscribed = true;
          var documentID;
          FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uId)
              .collection('memberShipModels')
              .where('name',isEqualTo:name)
              .get().then((value) {
            for (var snapshot in value.docs) {
               documentID = snapshot.id;
            }
            FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uId)
            .collection('memberShipModels')
            .doc(documentID)
            .set(m.toMap()).then((value) {
                 memberShipList = [];
                 getUserMemberShips();
            });
          } );

    }).catchError((error) {
      debugPrint(error.toString());

    });

  }
  
  void endSubscription(){
    late subscriptionModel j ;
    var d;
    var documentID;
    late bool validate;
    List<orderModel> orders = [];
    userMemberShipModel m = memberShipList.firstWhere((element) => element.isSubscribed == true);

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('subscription')
        .get().then((value) {
      for (var element in value.docs) {
        j = subscriptionModel.fromJson(element.data());
        d = element.id;
      }
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uId)
          .collection('subscription')
          .doc(d)
          .collection('orders')
          .snapshots().listen((event) {
        for(var element in event.docs) {
          orders.add(orderModel.fromJson(element.data()));
        }
      });
      DateTime? date2 = DateTime.tryParse(j.endDate!);
      validate = DateTime.now().isAfter(date2!);
    }).then((value) {
      if(validate){

        CacheHelper.saveData(key: 'isSubscribed', value: false);
        m.isSubscribed = false;

        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uId)
            .collection('memberShipModels')
            .where('isSubscribed',isEqualTo:true)
            .get().then((value) {
          for (var snapshot in value.docs) {
            documentID = snapshot.id;
          }
          FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uId)
              .collection('memberShipModels')
              .doc(documentID)
              .set(m.toMap()).then((value) {
            memberShipList = [];
            getUserMemberShips();
          });
            });


        FirebaseFirestore.instance
            .collection('subscriptionsHistory')
            .doc(user!.email)
            .collection('history')
            .add(j.toMap()).then((value) {
              var o = value.id;
              orders.forEach((element) {
                FirebaseFirestore.instance
                    .collection('subscriptionsHistory')
                    .doc(user!.email)
                    .collection('history')
                    .doc(o)
                    .collection('orders')
                    .doc(element.orderNo.toString())
                    .set(element.toMap());
              });
          FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uId)
              .collection('subscription')
              .doc(d).delete().then((value) {
                orders.forEach((element) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uId)
                      .collection('subscription')
                      .doc(d)
                      .collection('orders')
                      .doc(element.orderNo.toString())
                      .delete();
                });

          });


        });
        
      }
    });

  }

  late subscriptionModel? s = null;

  void getSubscription(){
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('subscription')
        .get().then((value) {
      for (var element in value.docs) {
        s = subscriptionModel.fromJson(element.data());
      }});
  }

  final noOfPiecesFormKey = GlobalKey<FormState>();
  final pickingUpFormKey = GlobalKey<FormState>();
  var elementId;
  Random random = new Random();
  int orderNumber = 0;

  void checkOrderValidation(context){
    orderNumber = random.nextInt(1000000);
    late List<bool> h= [false,false,false,false,false];
    late subscriptionModel j ;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('subscription')
        .get().then((value) {
      for (var element in value.docs) {
        j = subscriptionModel.fromJson(element.data());
        elementId = element.id;
      }
      }).then((value){
        if(j.isPaid == true) {
          DateTime? date2 = DateTime.tryParse(j.endDate!);
          h[0] = DateTime.now().isBefore(date2!);

          if (j.noOfOrders > 0) {
            h[1] = true;
          } else {
            h[1] = false;
          }

          if (int.tryParse(washingNumberController.text)! <= j.noOfWash!){
            h[2] = true;
          } else {
            h[2] = false;
          }

          if (int.tryParse(drycleaningNumberController.text)! <= j.noOfDryClean!){
            h[3] = true;
          } else {
            h[3] = false;
          }

          if (int.tryParse(ironNumberController.text)! <= j.noOfIron!){
            h[4] = true;
          } else {
            h[4] = false;
          }

        }else{
          Fluttertoast.showToast(msg: 'Please pay the subscription fee first');
        }
        }).then((value) {
      if(h[0] == true && h[1] == true && h[2] == true && h[3] == true && h[4] == true)
      {
        j.noOfOrders = (j.noOfOrders - 1) ;
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uId)
            .collection('subscription')
            .doc(elementId)
            .set(j.toMap());
        uploadSubscribedOrder(orderNumber: orderNumber);
        showDialog(context: context,
            builder: (context) =>
                AlertDialog(
                  content: Center(
                    child: Column(
                      children: [
                        const Text('your order number is : ',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold
                          ),),
                        space10Vertical(context),
                        Text(orderNumber.toString(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),),
                        space30Vertical(context),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.info_outline, color: Colors.grey,),
                            space5Horizontal(context),
                            const Expanded(
                              child:  Text('please save your order number,so you can track your order easily',
                                style:  TextStyle(color: Colors.grey),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Center(
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
                          child: MaterialButton(
                            onPressed: (){
                              Navigator.pop(context);
                              navigateTo(context, trackOrderScreen(),);
                              changeIndex(index: 0);
                            },
                            child: const Text(
                              "ok",
                              style: TextStyle(
                                color: Colors.teal,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                    ),
                  ],
                ));
        Fluttertoast.showToast(msg: 'order confirmed successfully :)',backgroundColor: Colors.green);
        closeOrder();
      } else {
        Fluttertoast.showToast(msg: 'something went wrong !',backgroundColor: Colors.red);
      }
    });
  }

  List<promoCodes> promoCode=[];

  void getPromoCodes(){
    FirebaseFirestore.instance
        .collection('promoCodes')
        .get().then((value) {
      for (var element in value.docs) {
        promoCode.add(promoCodes.fromJson(element.data()));
      }
    });
  }

  late double finalPrice;

  void checkPromoCodeValidation({required String text,}){
    getPromoCodes();
    promoCodes chosenCode = promoCode.firstWhere((element) => element.promoCode == text);
    DateTime dateTime1 = DateTime.now();
    DateTime? dateTime2 = DateTime.tryParse(chosenCode.startingDate!);
    DateTime? dateTime3 = DateTime.tryParse(chosenCode.endDate!);
    if(dateTime1.isBefore(dateTime3!) && dateTime1.isAfter(dateTime2!)){
      Fluttertoast.showToast(msg: 'promocode applied :)',backgroundColor: Colors.green);
      finalPrice = chosenCode.percentage!;

    }else if(dateTime1.isBefore(dateTime2!)){
      Fluttertoast.showToast(msg: 'promocode validation time hasn\'t started yet :)',backgroundColor: Colors.yellow);
    } else if(dateTime1.isAfter(dateTime3)){
      Fluttertoast.showToast(msg: 'promocode validation time has ended',backgroundColor: Colors.red);
    }else{
      Fluttertoast.showToast(msg: 'promocode not found',backgroundColor: Colors.red);
    }

  }

  void closeOrder(){
    images = [];
    comments = [];
    CacheHelper.saveData(key: 'y', value: false);
    washingNumberController.clear();
    drycleaningNumberController.clear();
    ironNumberController.clear();
    timeController.clear();
    dateController.clear();
    timeController1.clear();
    dateController1.clear();
    addressController.clear();
    promocodeController.clear();
  }

  void uploadSubscribedOrder({required int orderNumber}) async {

    order = orderModel(
      noOfWash : int.tryParse(washingNumberController.text),
      noOfDryClean : int.tryParse(drycleaningNumberController.text),
      noOfIron : int.tryParse(ironNumberController.text),
      comment: comments,
      imageUrls: imageUrls,
      user : user!.email,
      address : addressController.text,
      pickupDate : dateController.text,
      pickupTime : timeController.text,
      dropdownDate : dateController1.text,
      dropdownTime : timeController1.text,
      orderNo : orderNumber,
      orderNoSubscription: s!.noOfOrders,
      isPaid : CacheHelper.getData(key: 'isSubscribed'),
      orderMade : false,
      waitingForPickup : false,
      deliveryOnTheWay : false,
      deliveryArrived : false,
      orderInProgress : false,
      orderIsWashing : false,
      orderIroning : false,
      waitingForDroppingDown : false,
      deliveryOnTheWayBack : false,
      deliveryArrivedBack : false,
      rateYourOrder : false,);

    String f = order.orderNo.toString();
    String r = user!.uId!;
    images.forEach((element) {
      FirebaseStorage.instance
        .ref()
        .child('orderPictures/$r/$f')
        .putFile(element).then((p0) {
      FirebaseStorage.instance
          .ref()
          .child('orderPictures/$r/$f')
          .getDownloadURL().then((value) {
        imageUrls.add(value);
        order.imageUrls = imageUrls;
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uId)
            .collection('subscription')
            .doc(elementId)
            .collection('orders')
            .doc(orderNumber.toString())
            .set(order.toMap());
      });
     });
    });

  }

  void uploadUnSubscribedOrder(context){

    orderNumber = random.nextInt(1000000);

    order = orderModel(
      noOfWash : int.tryParse(washingNumberController.text),
      noOfDryClean : int.tryParse(drycleaningNumberController.text),
      noOfIron : int.tryParse(ironNumberController.text),
      comment: comments,
      imageUrls: imageUrls,
      user : user!.email,
      address : addressController.text,
      pickupDate : dateController.text,
      pickupTime : timeController.text,
      dropdownDate : dateController1.text,
      dropdownTime : timeController1.text,
      orderNo : orderNumber,
      isPaid : CacheHelper.getData(key: 'isSubscribed'),
      orderMade : false,
      waitingForPickup : false,
      deliveryOnTheWay : false,
      deliveryArrived : false,
      orderInProgress : false,
      orderIsWashing : false,
      orderIroning : false,
      waitingForDroppingDown : false,
      deliveryOnTheWayBack : false,
      deliveryArrivedBack : false,
      rateYourOrder : false,);

    String f = order.orderNo.toString();
    String r = user!.uId!;
    images.forEach((element) { FirebaseStorage.instance
        .ref()
        .child('orderPictures/$r/$f')
        .putFile(element).then((p0) {
      FirebaseStorage.instance
          .ref()
          .child('orderPictures/$r/$f')
          .getDownloadURL().then((value) {
            imageUrls.add(value);
            order.imageUrls = imageUrls;
            FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uId)
                .collection('orders')
                .doc(orderNumber.toString())
                .set(order.toMap());
      });
     });
    });

    showDialog(context: context,
        builder: (context) =>
            AlertDialog(
              content: Center(
                child: Column(
                  children: [
                    const Text('your order number is : ',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold
                      ),),
                    space10Vertical(context),
                    Text(orderNumber.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),),
                    space30Vertical(context),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, color: Colors.grey,),
                        space5Horizontal(context),
                        const Expanded(
                          child:  Text('please save your order number,so you can track your order easily',
                            style:  TextStyle(color: Colors.grey),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.pop(context);
                        navigateTo(context, trackOrderScreen(),);
                        changeIndex(index: 0);
                      },
                      child: const Text(
                        "ok",
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ],
            ));
    Fluttertoast.showToast(msg: 'order confirmed successfully :)',backgroundColor: Colors.green);
    closeOrder();

  }

  List<File> images = [];
  List<String> imageUrls = [];
  List<String> comments = [];

  void sendNotification({required String title, required String body, Map<String, dynamic>? data}){
    String token = FirebaseMessaging.instance.getToken().toString();
    Map<String, dynamic> notification = {
      'title' : title,
      'body' : body,
      'sound' : 'default',
   };
    Map<String, dynamic> notification1 = {
      'notification_priority' : 'PRIORITY_MAX',
      'sound' : 'default',
      'default_sound' : true,
      'default_vibrate_timings': true,
      'default_light_settings' : true,
    };
    Map<String, dynamic> android = {
      'priority' : 'HIGH',
      'notification' : notification1,
    };
    notificationModel notificationData = notificationModel(
      token: token,
      notification: notification,
      android: android,
      data: data,
    );
    DioHelper.postData(data: notificationData.toMap());
}

}