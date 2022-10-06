import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maghsala/take_picture.dart';
import '/new_order_layout.dart';
import '/constants.dart';
import '/cubit/cubit.dart';
import 'cubit/state.dart';

class orderPhotoPreview extends StatefulWidget {
  const orderPhotoPreview({Key? key}) : super(key: key);

  @override
  State<orderPhotoPreview> createState() => _orderPhotoPreviewState();
}

class _orderPhotoPreviewState extends State<orderPhotoPreview> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  navigateAndFinish(
                    context,
                    const newOrderLayout(),
                  );
                  cubit.changeIndex(
                    index: 0,
                  );
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              title: const Text('New Order'),
            ),
            body: Column(
              children: [
                space20Vertical(context),
               if(cubit.images.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => imageItem(image: cubit.images[index],comment: cubit.comments[index],),
                      separatorBuilder: (context, index) => const MyDivider(),
                      itemCount: cubit.images.length),
                ),
               if(cubit.images.isEmpty)
                Center(
                  child: Column(
                  children : [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.network('https://img.freepik.com/free-vector/computer-troubleshooting-abstract-concept-illustration_335657-2211.jpg?w=740&t=st=1661782015~exp=1661782615~hmac=bee7358e32b6ffa1bc4f48fba6daf03b66d1859e2391423943f824d3f59f25fa',
                      fit: BoxFit.cover,),
                    ),
                    space10Vertical(context),
                    const Text('No images yet',style: const TextStyle(fontSize: 22),)
                   ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: MaterialButton(
                      onPressed: (){
                        navigateAndFinish(context, CameraScreen(),);
                      },
                      child: cubit.images.isEmpty ?
                          const Text(
                        "Add photo",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                          :const Text(
                        "Add another photo",
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
                ),
                space20Vertical(context)

              ],
            ),
          );
        });
  }
}

class imageItem extends StatefulWidget {
  final File image;
  final String comment;

  const imageItem({
    Key? key,
    required this.image,
    required this.comment,
  }) : super(key: key);

  @override
  State<imageItem> createState() => _imageItemState();
}

class _imageItemState extends State<imageItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.white, width: 2),
                  image: DecorationImage(
                    image: FileImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              space15Horizontal(context),
              Text(
                widget.comment,
                style: const TextStyle(
                  fontSize: 19,
                ),
              ),
              const Spacer(),
              Container(
                height:40 ,
                width:40 ,
                child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        AppBloc
                            .get(context)
                            .images
                            .remove(widget.image);
                        AppBloc
                            .get(context)
                            .comments
                            .remove(widget.comment);
                      });
                    },
                    backgroundColor: Colors.white30,
                    foregroundColor: Colors.black,
                    child : const Icon(Icons.delete_outline_rounded)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
