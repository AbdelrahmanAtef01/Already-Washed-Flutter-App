import 'package:flutter/material.dart';
import 'package:maghsala/track_order.dart';
import '/constants.dart';
import '/cubit/cubit.dart';
import '/network/local/cache_helper.dart';

class purchaseScreen extends StatefulWidget {
  const purchaseScreen({Key? key}) : super(key: key);

  @override
  State<purchaseScreen> createState() => _purchaseScreenState();
}

class _purchaseScreenState extends State<purchaseScreen> {

  @override
  Widget build(BuildContext context) {
    var cubit = AppBloc.get(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children:
        [
          if(CacheHelper.getData(key: 'isSubscribed') == false)
           Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Promo code : ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
              const SizedBox(height: 4,),
              TextFormField(
                cursorColor: Colors.teal,
                controller: cubit.promocodeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  suffixIcon:Icon(Icons.local_offer_outlined),
                  border : OutlineInputBorder(),
                  hintText: 'you can apply your promo code here...',
                ),
                onTap: () {
                },
              ),
              space10Vertical(context),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 150,
                  height: 50.0,
                  child: MaterialButton(
                    onPressed: (){
                      cubit.checkPromoCodeValidation(text: cubit.promocodeController.text);
                    },
                    child: const Text(
                      "Apply promo code",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
          space20Vertical(context),
          if(CacheHelper.getData(key: 'isSubscribed') == true)
            const Center(
              child: Text('you\'re already subscribed,\nFinish your order now:)',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),)),
          if(CacheHelper.getData(key: 'isSubscribed') == false)
            const Center(
              child: Text('your order will be 500 EGP,\n Confirm your order now:)',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),)),
          space30Vertical(context),
          Container(
            width: double.infinity,
            height: 50.0,
            child: MaterialButton(
              onPressed: (){
                if(CacheHelper.getData(key: 'isSubscribed') == true) {
                  cubit.checkOrderValidation(context);
                }else {cubit.uploadUnSubscribedOrder(context);}
                },
              child: const Text(
                "Confirm order",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                5,
              ),
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}