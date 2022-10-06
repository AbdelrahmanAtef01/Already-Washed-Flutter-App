import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maghsala/chat_screen.dart';
import 'package:maghsala/constants.dart';
import 'package:maghsala/my_chats_screen.dart';
import 'package:maghsala/sendEmail.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'home_layout.dart';
import 'network/local/cache_helper.dart';

class contactScreen extends StatefulWidget {
  const contactScreen({Key? key}) : super(key: key);

  @override
  State<contactScreen> createState() => _contactScreenState();
}

class _contactScreenState extends State<contactScreen> {

  @override
  void initState() {
    super.initState();

    AppBloc.get(context).getMessages();
  }

   @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppBloc, AppState>(
         listener: (context, state) {},
         builder: (context, state) {
           var cubit = AppBloc.get(context);
           return Scaffold(
             appBar: AppBar(
               leading: IconButton(icon:const Icon(Icons.arrow_back_ios_new_rounded),
                 onPressed: () { navigateAndFinish(context, const HomeLayoutScreen(),); },),
               title: const Text('Contact with us'),
             ),
             body: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children: [
                    const SizedBox(height: 10,),
                   Row(
                     children: [
                       const Text('- Contact with our customer service : ',
                         style: TextStyle(
                           fontSize: 17,
                           fontWeight: FontWeight.w500,
                         ),),
                       const SizedBox(width: 20,),
                       IconButton(
                         color: Colors.teal,
                           onPressed: (){
                             cubit.makingPhoneCall();},
                           icon: Icon(Icons.phone)),
                     ],
                   ),
                   const SizedBox(height: 15,),
                   Row(
                     children: [
                       Text('- Email our customer service : ',
                         style: TextStyle(
                           fontSize: 17,
                           fontWeight: FontWeight.w500,
                         ),),
                       const SizedBox(width: 20,),
                       IconButton(
                           color: Colors.teal,
                           onPressed: (){navigateTo(context, sendEmail());},
                           icon: Icon(Icons.email)),
                     ],
                   ),
                   const SizedBox(height: 15,),
                   Row(
                     children: [
                       Text('- Chat with us : ',
                         style: TextStyle(
                           fontSize: 17,
                           fontWeight: FontWeight.w500,
                         ),),
                       const SizedBox(width: 20,),
                       Stack(
                         children: [
                           IconButton(
                               color: Colors.teal,
                               onPressed: (){
                                 cubit.getMessages();
                                 if(user!.uId == contactingWay!.receiverId)
                                 {
                                   navigateTo(context, myChatsScreen(),);

                                 }else{
                                   navigateTo(context, chatScreen(),);
                                 }
                                 },
                               icon: Icon(Icons.chat_outlined)),
                          if(CacheHelper.getData(key: 'messagesLength') != null && CacheHelper.getData(key: 'messagesLength') < cubit.messagesList.length)
                           const Positioned(
                             top: 4,
                             right: 5,
                             child: Icon(Icons.circle,
                               color: Colors.red,
                               size: 18,),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ],
               ),
             ),
           );
         }
     );
   }
}