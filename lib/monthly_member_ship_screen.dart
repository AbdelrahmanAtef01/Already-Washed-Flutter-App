import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants.dart';
import 'member_ship_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class MonthlyMemberShipScreen extends StatefulWidget {
  const MonthlyMemberShipScreen({Key? key}) : super(key: key);

  @override
  State<MonthlyMemberShipScreen> createState() => _MonthlyMemberShipScreenState();
}

class _MonthlyMemberShipScreenState extends State<MonthlyMemberShipScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(icon:const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () { navigateAndFinish(context, const MemberShipScreen(),); },),
              title: const Text('MEMBER SHIP'),
            ),
            body: Column(
              children: [
                Container(
                  height: 40,
                  color: Colors.amberAccent,
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      'Monthly packages',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ),
                ),
                space20Vertical(context),
                Expanded(
                  child:ListView.separated(
                      itemBuilder: (context,index) => memberShipBuilder(type: 'monthly',memberShip: cubit.monthlyMemberShipList[index],),
                      separatorBuilder:(context,index) => const MyDivider(),
                      itemCount: cubit.monthlyMembershipLength),
                ),
              ],
            ),
          );
        }
    );
  }
}