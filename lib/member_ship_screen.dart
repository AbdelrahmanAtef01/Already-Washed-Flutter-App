import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/models/user_member_ship_model.dart';
import '/network/local/cache_helper.dart';
import 'annually_member_ship_screen.dart';
import 'monthly_member_ship_screen.dart';
import 'weekly_member_ship_screen.dart';
import 'constants.dart';
import 'home_layout.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class MemberShipScreen extends StatefulWidget {
  const MemberShipScreen({Key? key}) : super(key: key);

  @override
  State<MemberShipScreen> createState() => _MemberShipScreenState();
}

class _MemberShipScreenState extends State<MemberShipScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(icon:const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () { navigateAndFinish(context, const HomeLayoutScreen(),);},),
              title: const Text('MEMBER SHIP'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                space20Vertical(context),
                Expanded(
                  child:InkWell(
                    onTap: (){navigateTo(context, const WeeklyMemberShipScreen(),);},
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            //width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            child: Image.network('https://img.freepik.com/free-photo/colorful-towels-liquid-laundry-detergent_93675-135766.jpg?w=740&t=st=1661097535~exp=1661098135~hmac=51e92b0eb97f1149323b6a59f99f6b3fc2641fd947fb5775e29eb1bc5625895e'),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text('Weekly memberships',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child:InkWell(
                    onTap: (){navigateTo(context, const MonthlyMemberShipScreen());},
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            //width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            child: Image.network('https://img.freepik.com/free-photo/unrecognizable-man-ironing-shirts-laundry-home_1098-17141.jpg?w=740&t=st=1661097355~exp=1661097955~hmac=9f266e1f6b85718a8ba10a93f976781175df5f13b3b02ea7307be0c0598a861e'),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text('Monthly memberships',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child:InkWell(
                    onTap: (){navigateTo(context, const AnnuallyMemberShipScreen());},
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            child: Image.network('https://img.freepik.com/free-photo/woman-putting-clothes-dryer-home_23-2149117050.jpg?t=st=1661097495~exp=1661098095~hmac=51af9551bb55c7af5f55d61f82ed69ce5d1b191febd285322af05776bf88629a'),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text('Annually memberships',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
                space20Vertical(context),
              ],
            ),
          );
        }
    );
  }
}

class memberShipBuilder extends StatelessWidget
{
  final String type;
  final userMemberShipModel memberShip;
  memberShipBuilder({
    required this.memberShip,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = memberShip.name!;
    String memberShipType = memberShip.type!;
    int noOfOrders = memberShip.noOfOrders!;
    int noOfWash = memberShip.noOfWash!;
    int noOfDryClean = memberShip.noOfDryClean!;
    int noOfIron = memberShip.noOfIron!;
    int price = memberShip.price!;
    bool isSubscribed = memberShip.isSubscribed!;

    if(memberShip.type == 'weekly' && type == 'weekly') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Already washed $name package',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                space5Vertical(context),
                Text('type : $memberShipType',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                space5Vertical(context),
                Text('maximum of $noOfOrders orders',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space5Vertical(context),
                Text('maximum of $noOfWash pieces per order to wash',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space5Vertical(context),
                Text('maximum of $noOfDryClean piece per order to dryclean',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space5Vertical(context),
                Text('maximum of $noOfIron pieces per order to iron',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space10Vertical(context),
                Text('price : $price',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space20Vertical(context),
                if(isSubscribed == false)
                  Container(
                    height: 42.0,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: MaterialButton(
                      height: 42.0,
                      onPressed: () {
                        CacheHelper.getData(key: 'isSubscribed') == true?
                            Fluttertoast.showToast(msg: 'you\'re already subscribed',backgroundColor: Colors.red)
                          :AppBloc.get(context).setSubscription(i: 1,name: name);},
                      child: const Text(
                        'Subscribe now',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                if(isSubscribed)
                  Container(
                    height: 42.0,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Subscribed !',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }
    if(memberShip.type == 'monthly' && type == 'monthly') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Already washed $name package',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                space5Vertical(context),
                Text('type : $memberShipType',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                space5Vertical(context),
                Text('maximum of $noOfOrders orders',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space5Vertical(context),
                Text('maximum of $noOfWash pieces per order to wash',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space5Vertical(context),
                Text('maximum of $noOfDryClean piece per order to dryclean',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space5Vertical(context),
                Text('maximum of $noOfIron pieces per order to iron',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space10Vertical(context),
                Text('price : $price',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space20Vertical(context),
                if(isSubscribed == false)
                  Container(
                    height: 42.0,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: MaterialButton(
                      height: 42.0,
                      onPressed: () {
                        CacheHelper.getData(key: 'isSubscribed') == true?
                        Fluttertoast.showToast(msg: 'you\'re already subscribed',backgroundColor: Colors.red)
                            :AppBloc.get(context).setSubscription(i: 2,name: name);
                      },
                      child: const Text(
                        'Subscribe now',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                if(isSubscribed)
                  Container(
                    height: 42.0,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Subscribed !',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

              ],
            ),
          ),
        ),
      );
    }
    if (memberShip.type == 'annually' && type == 'annually') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Already washed $name package',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                space5Vertical(context),
                Text('type : $memberShipType',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                space5Vertical(context),
                Text('maximum of $noOfOrders orders',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space5Vertical(context),
                Text('maximum of $noOfWash pieces per order to wash',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space5Vertical(context),
                Text('maximum of $noOfDryClean piece per order to dryclean',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space5Vertical(context),
                Text('maximum of $noOfIron pieces per order to iron',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space10Vertical(context),
                Text('price : $price',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
                space20Vertical(context),
                if(isSubscribed == false)
                  Container(
                    height: 42.0,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: MaterialButton(
                      height: 42.0,
                      onPressed: () {
                        CacheHelper.getData(key: 'isSubscribed') == true?
                        Fluttertoast.showToast(msg: 'you\'re already subscribed',backgroundColor: Colors.red)
                            :AppBloc.get(context).setSubscription(i: 3,name: name);
                      },
                      child: const Text(
                        'Subscribe now',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                if(isSubscribed)
                  Container(
                    height: 42.0,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Subscribed !',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }
    else {
      return const Center(child: Text('none'));
    }


  }


}