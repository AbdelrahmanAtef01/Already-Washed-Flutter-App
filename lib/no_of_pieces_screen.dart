import 'package:flutter/material.dart';
import 'package:maghsala/network/local/cache_helper.dart';
import 'package:maghsala/order_photo_preview.dart';
import '/constants.dart';
import '/cubit/cubit.dart';
import '/take_picture.dart';

class noOfPiecesScreen extends StatefulWidget {
  const noOfPiecesScreen({Key? key}) : super(key: key);

  @override
  State<noOfPiecesScreen> createState() => _noOfPiecesScreenState();
}

class _noOfPiecesScreenState extends State<noOfPiecesScreen> {



  @override
  Widget build(BuildContext context) {
    var cubit = AppBloc.get(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: cubit.noOfPiecesFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            const Text('no. of pieces to wash : ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),),
            TextFormField(
              cursorColor: Colors.teal,
              validator: (value) {
                var c = int.tryParse(value.toString());
                if (value!.isEmpty) {
                  return 'no. of pieces to wash must not be empty';
                }else if(cubit.s != null){
                  if(c! > cubit.s!.noOfWash! && CacheHelper.getData(key: 'isSubscribed') == true){
                  return 'you must n\'t exceed the limit of the subscription';
                }}
                return null;
              },
              controller: cubit.washingNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: false,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
              ),
            ),
            space5Vertical(context),
            const Text('you can add here the amount of pieces that need to be washed, '
                'ex: shirts ,trousers, shorts ,dresses',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),),
            space20Vertical(context),
            const Text('no. of pieces to dryclean : ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),),
            TextFormField(
              cursorColor: Colors.teal,
              validator: (value) {
                var c = int.tryParse(value.toString());
                if (value!.isEmpty) {
                  return 'no. of pieces to dry clean must not be empty';
                }else if(cubit.s != null){
                  if(c! > cubit.s!.noOfDryClean! && CacheHelper.getData(key: 'isSubscribed') == true){
                  return 'you must n\'t exceed the limit of the subscription';
                }}
                return null;
              },
              controller: cubit.drycleaningNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: false,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
              ),
            ),
            space5Vertical(context),
            const Text('you can add here the amount of pieces that need to be dry cleaned, '
                'ex: suits, jackets, dresses',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),),
            space20Vertical(context),
            const Text('no. of pieces to iron : ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),),
            TextFormField(
              cursorColor: Colors.teal,
              validator: (value) {
                var c = int.tryParse(value.toString());
                if (value!.isEmpty) {
                  return 'no. of pieces to iron must not be empty';
                }else if(cubit.s != null){
                  if(c! > cubit.s!.noOfIron! && CacheHelper.getData(key: 'isSubscribed') == true){
                  return 'you must n\'t exceed the limit of the subscription';
                }}
                return null;
              },
              controller: cubit.ironNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: false,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
              ),
            ),
            space5Vertical(context),
            const Text('you can add here the amount of pieces that need to be ironed ',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),),
            space20Vertical(context),
            const Text('Add photos for specific spots to focus on them ? ',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),),
            IconButton(onPressed: (){
              navigateTo(context, orderPhotoPreview());
            },
              icon: const Icon(Icons.add_a_photo_outlined),
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
