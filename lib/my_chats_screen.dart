import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/chat_screen.dart';
import '/contact_screen.dart';
import '/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class myChatsScreen extends StatefulWidget {
  const myChatsScreen({Key? key}) : super(key: key);
  @override
  State<myChatsScreen> createState() => _myChatsScreenState();
}

class _myChatsScreenState extends State<myChatsScreen> {

  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(icon:const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () { navigateAndFinish(context, const contactScreen(),); },),
              title: const Text('chat console'),
            ),
            body: ListView.separated(
                itemBuilder: (context, index) => userBuilder(index: index),
                separatorBuilder: (context, index) => const MyDivider(),
                itemCount: cubit.usersList.length),
          );
        }
    );
  }
}
class userBuilder extends StatelessWidget
{
  int index;
  userBuilder({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap:(){
            chatUser = AppBloc.get(context).usersList[index];
            navigateTo(context, const chatScreen(),);
        },
        child:Container(
          width: double.infinity,
          height: 50,
          color: Colors.grey,
          child: Center(child: Text(AppBloc.get(context).usersList[index].email!,
            style: const TextStyle(fontSize:17 ),)),
        ),
      ),
    );
  }


}