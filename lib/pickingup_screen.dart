import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '/constants.dart';
import '/cubit/cubit.dart';

class pickingUpScreen extends StatefulWidget {
  const pickingUpScreen({Key? key}) : super(key: key);

  @override
  State<pickingUpScreen> createState() => _pickingUpScreenState();
}

class _pickingUpScreenState extends State<pickingUpScreen> {


  Color pickupColor = Colors.grey;
  Color dropdownColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    var cubit = AppBloc.get(context);
     return InkWell(
       onTap: (){
         setState(() {
           dropdownColor = Colors.grey;
           pickupColor = Colors.grey;
         });
       },
       child: Padding(
         padding: const EdgeInsets.all(15.0),
         child: Form(
           key: cubit.pickingUpFormKey,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
                   children:
                   [
                     const Text('Schedule picking up : ',
                       style: TextStyle(
                         fontSize: 22,
                         fontWeight: FontWeight.w500,
                       ),),
                     const SizedBox(
                       height: 4.0,
                     ),
                     DottedBorder(
                       color: pickupColor,
                       strokeWidth: 2,
                       dashPattern: const [
                         5,
                         5,
                       ],
                       child: InkWell(

                         onTap:(){
                           setState((){
                             pickupColor = Colors.teal;
                             dropdownColor = Colors.grey;
                           });
                         } ,
                         child: Container(
                           child: Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 const Text('- pickup date : ',
                                     style: TextStyle(
                                       fontSize: 20,
                                       fontWeight: FontWeight.bold,
                                     ),),
                                 const SizedBox(height: 15,),
                                 TextFormField(
                                   cursorColor: Colors.teal,
                                         controller: cubit.dateController,
                                         keyboardType: TextInputType.datetime,
                                         decoration: const InputDecoration(
                                           suffixIcon:Icon(Icons.arrow_drop_down),
                                           border : OutlineInputBorder(),
                                           labelText: 'Choose date',
                                         ),
                                         onTap: () {
                                           setState((){
                                             pickupColor = Colors.teal;
                                             dropdownColor = Colors.grey;
                                           });
                                           showDatePicker(
                                             context: context,
                                             initialDate: DateTime.now(),
                                             firstDate: DateTime.now(),
                                             lastDate: DateTime.parse('2022-12-03'),
                                           ).then((value) {
                                             cubit.dateController.text =
                                                 DateFormat.yMMMd().format(value!);
                                           });
                                         },
                                       ),
                                 const SizedBox(height: 15,),
                                 const MyDivider(),
                                 const SizedBox(height: 15,),
                                 const Text('- pickup time : ',
                                   style: TextStyle(
                                     fontSize: 20,
                                     fontWeight: FontWeight.bold,
                                   ),),
                                 const SizedBox(height: 15,),
                                 TextFormField(
                                   cursorColor: Colors.teal,
                                   controller: cubit.timeController,
                                   keyboardType: TextInputType.datetime,
                                   decoration: const InputDecoration(
                                     suffixIcon:Icon(Icons.arrow_drop_down),
                                     border : OutlineInputBorder(),
                                     labelText: 'Choose time',
                                   ),
                                   onTap: () {
                                     setState((){
                                       pickupColor = Colors.teal;
                                       dropdownColor = Colors.grey;
                                     });
                                     showTimePicker(
                                       context: context,
                                       initialTime: TimeOfDay.now(),
                                     ).then((value) {
                                       cubit.timeController.text =
                                           value!.format(context).toString();
                                     });
                                   },
                                 ),
                                 const SizedBox(height: 15,),
                               ],
                             ),
                           ),
                         ),
                       ),
                     ),
                     const SizedBox(height: 25,),
                     const Text('Schedule dropping down : ',
                       style: TextStyle(
                         fontSize: 22,
                         fontWeight: FontWeight.w500,
                       ),),
                     const SizedBox(
                       height: 4.0,
                     ),
                     DottedBorder(
                       color: dropdownColor,
                       strokeWidth: 2,
                       dashPattern: const [
                         5,
                         5,
                       ],
                       child: InkWell(
                         onTap: (){
                           setState((){
                             pickupColor = Colors.grey;
                             dropdownColor = Colors.teal;
                           });
                         },
                         child: Container(
                           child: Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 const Text('- Drop down date : ',
                                   style: TextStyle(
                                     fontSize: 20,
                                     fontWeight: FontWeight.bold,
                                   ),),
                                 const SizedBox(height: 15,),
                                 TextFormField(
                                   cursorColor: Colors.teal,
                                   controller: cubit.dateController1,
                                   keyboardType: TextInputType.datetime,
                                   decoration: const InputDecoration(
                                     suffixIcon:Icon(Icons.arrow_drop_down),
                                     border : OutlineInputBorder(),
                                     labelText: 'Choose date',
                                   ),
                                   onTap: () {
                                     setState((){
                                       pickupColor = Colors.grey;
                                       dropdownColor = Colors.teal;
                                     });
                                     showDatePicker(
                                       context: context,
                                       initialDate: DateTime.now(),
                                       firstDate: DateTime.now(),
                                       lastDate: DateTime.parse('2022-12-03'),
                                     ).then((value) {
                                       cubit.dateController1.text =
                                           DateFormat.yMMMd().format(value!);
                                     });
                                   },
                                 ),
                                 const SizedBox(height: 15,),
                                 const MyDivider(),
                                 const SizedBox(height: 15,),
                                 const Text('- Drop down time : ',
                                   style: TextStyle(
                                     fontSize: 20,
                                     fontWeight: FontWeight.bold,
                                   ),),
                                 const SizedBox(height: 15,),
                                 TextFormField(
                                   cursorColor: Colors.teal,
                                   controller: cubit.timeController1,
                                   keyboardType: TextInputType.datetime,
                                   decoration: const InputDecoration(
                                     suffixIcon:Icon(Icons.arrow_drop_down),
                                     border : OutlineInputBorder(),
                                     labelText: 'Choose time',
                                   ),
                                   onTap: () {

                                     setState((){
                                       pickupColor = Colors.grey;
                                       dropdownColor = Colors.teal;
                                     });
                                     showTimePicker(
                                       context: context,
                                       initialTime: TimeOfDay.now(),
                                     ).then((value) {
                                       cubit.timeController1.text =
                                           value!.format(context).toString();
                                     });
                                   },
                                 ),
                                 const SizedBox(height: 15,),
                               ],
                             ),
                           ),
                         ),
                       ),
                     ),
                     space30Vertical(context),
                     const Text('pick from : ',
                       style: TextStyle(
                         fontSize: 22,
                         fontWeight: FontWeight.w500,
                       ),),
                     space4Vertical(context),
                     Row(
                       children: [
                         Expanded(
                             child:TextFormField(
                               onTap: (){
                                 setState(() {
                                   pickupColor = Colors.grey;
                                   dropdownColor = Colors.grey;
                                 });
                               },
                               cursorColor: Colors.teal,
                               validator: (value) {
                                 if (value!.isEmpty) {
                                   return 'the address must not be empty';
                                 }
                                 return null;
                               },
                               controller: cubit.addressController,
                               keyboardType: TextInputType.streetAddress,
                               decoration: InputDecoration(
                                 hintText: 'Address',
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
                             ) ,
                         ),
                         space10Horizontal(context),
                         Container(
                           width: 100,
                           height: 50.0,
                           child: MaterialButton(
                             onPressed: (){
                                user!.address != '' || user!.address != null ?
                               cubit.addressController.text = user!.address:
                                Fluttertoast.showToast(msg: 'you haven\'t saved an address yet',backgroundColor: Colors.red);
                             },
                             child: const Text(
                               "use saved address",
                               style: TextStyle(
                                 color: Colors.white,
                               ),
                             ),
                           ),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(
                               15,
                             ),
                             color: Colors.teal,
                           ),
                         ),
                       ],
                     ),

                   ],
                 ),
         ),
       ),
     );
  }
}
