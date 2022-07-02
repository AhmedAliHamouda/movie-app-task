import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app_task/ui/widgets/custom_text.dart';
import 'package:movies_app_task/ui/widgets/loading_widget.dart';
import 'package:movies_app_task/utils/colors_utils.dart';
import 'package:movies_app_task/network/service_urls.dart';
import 'package:movies_app_task/viewModels/global_riverpod_container.dart';
import 'package:movies_app_task/viewModels/person_riverpod.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'widgets/person_detail_widget.dart';

class PersonDetailScreen extends StatefulWidget {
  final int id;

  const PersonDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _PersonDetailScreenState createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      await providerContainer.read(personRiverPod).getPersonData(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final personProv = ref.watch(personRiverPod);
          return personProv.loadingPersonData
              ?  const LoadingWidget()
              : SingleChildScrollView(
                  child: Stack(
                    children: [
                      if(personProv.personDetailModel!=null)...[
                        ShapeOfView(
                          elevation: 4,
                          height: 300,
                          shape: DiagonalShape(
                            position: DiagonalPosition.Bottom,
                            direction: DiagonalDirection.Left,
                            angle: DiagonalAngle.deg(angle: 15),
                          ),
                          child: personProv.personImagesModel != null
                              ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child:  CachedNetworkImage(
                                imageUrl:personProv.personImagesModel!.profiles!.isEmpty?'': ServicesURLs.mainImageUrlHq +
                                    personProv.personImagesModel!.profiles![personProv.personImagesModel!.profiles?.length == 1?0:1].filePath!,
                                placeholder: (context, url) => Container(color: ColorsUtils.blackColor),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                fit: BoxFit.fill,
                              )
                          )
                              : Container(
                            color: Colors.black54,
                          ),
                        ),
                        PersonDetailWidget(
                          personDetailModel: personProv.personDetailModel,
                          personImagesModel: personProv.personImagesModel,
                        ),
                      ]else...[
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: const CustomText(
                            text: 'Load Data Failed',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                      ],

                      Positioned(
                          top: 40,
                          left: 10,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              iconSize: 25,
                              color: ColorsUtils.whiteColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
