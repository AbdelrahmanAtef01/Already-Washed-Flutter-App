import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/contact_screen.dart';
import '/constants.dart';
import '/my_chats_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'models/message_model.dart';

class chatScreen extends StatefulWidget {
  const chatScreen({Key? key,}) : super(key: key);

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {

  @override
  void initState() {
    super.initState();
    AppBloc.get(context).getMessagesNotification();
    AppBloc.get(context).getMessages();
  }

  @override
  void dispose() {
    AppBloc.get(context).deleteMessages();
    AppBloc.get(context).getMessagesNotification();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state){},
      builder: (context, state) {
        var cubit = AppBloc.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(icon:Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
              cubit.messagesList=[];
              if(user!.uId == contactingWay!.receiverId){
                navigateAndFinish(context, myChatsScreen(),);
              }else {
                navigateAndFinish(context, contactScreen(),);
              }
              },),
            title: Text(
              'Chat with us'
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (cubit.messagesList.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (cubit.messagesList[index].senderId == user!.uId) {
                          return MyItem(
                            model: cubit.messagesList[index],
                          );
                        }

                        return UserItem(
                          model: cubit.messagesList[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          space10Vertical(context),
                      itemCount: cubit.messagesList.length,
                    ),
                  ),
                if (cubit.messagesList.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text('\nwe are pleased to hear from you :)\n\n'
                          'write your problem or suggestion here ...',
                          style:TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                      ),
                    ),
                  ),
                space20Vertical(context),
                TextFormField(
                  controller: cubit.messageController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'type message',
                    border: const OutlineInputBorder(),
                    suffixIcon: MaterialButton(
                      minWidth: 1,
                      onPressed: () {
                        cubit.sendMessage();
                        cubit.getMessagesNotification();
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyItem extends StatelessWidget {
  final MessageDataModel model;

  const MyItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(
                  15.0,
                ),
                topEnd: Radius.circular(
                  15.0,
                ),
                bottomStart: Radius.circular(
                  15.0,
                ),
              ),
              color: Colors.teal,
            ),
            child: Text(
              model.message!,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UserItem extends StatelessWidget {
  final MessageDataModel model;

  const UserItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(
                  15.0,
                ),
                topEnd: Radius.circular(
                  15.0,
                ),
                bottomEnd: Radius.circular(
                  15.0,
                ),
              ),
              color: Colors.grey,
            ),
            child: Text(
              model.message!,
              style: const TextStyle(),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}