import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants.dart';
import 'member_ship_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class AnnuallyMemberShipScreen extends StatefulWidget {
  const AnnuallyMemberShipScreen({Key? key}) : super(key: key);

  @override
  State<AnnuallyMemberShipScreen> createState() => _AnnuallyMemberShipScreenState();
}

class _AnnuallyMemberShipScreenState extends State<AnnuallyMemberShipScreen> {

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
                      'Annually packages',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ),
                ),
                space20Vertical(context),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context,index) => memberShipBuilder(type: 'annually',memberShip: cubit.annuallyMemberShipList[index],),
                      separatorBuilder:(context,index) => const MyDivider(),
                      itemCount: cubit.annuallyMembershipLength),
                ),

              ],
            ),
          );
        }
    );
  }
}