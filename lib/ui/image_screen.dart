import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app_task/ui/widgets/custom_text.dart';
import 'package:movies_app_task/ui/widgets/loading_widget.dart';
import 'package:movies_app_task/utils/colors_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app_task/utils/custom_functions.dart';
import 'package:movies_app_task/network/service_urls.dart';
import 'package:movies_app_task/viewModels/person_riverpod.dart';

class ImageScreen extends StatelessWidget {
  final String imagePath;
  const ImageScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: 'Photo',
        ),
        backgroundColor: ColorsUtils.blackColor,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              imageUrl: ServicesURLs.mainImageUrlHq + imagePath,
              placeholder: (context, url) => Container(color: ColorsUtils.blackColor),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 15.0,
            child: Consumer(
              builder: (context, ref, child) {
                final personProv = ref.watch(personRiverPod);
                return personProv.loadingSaveImage
                    ? const LoadingWidget(
                  color: ColorsUtils.scaffoldBackGroundColor,
                )
                    : ElevatedButton(
                        onPressed: () async {
                          final responseImage=await personProv.saveImageToGallery(ServicesURLs.mainImageUrlHq+imagePath);
                          if(responseImage){
                            CustomFunctions.showCustomSnackBar(text: 'Photo Saved Successfully', context: context,backgroundColor: ColorsUtils.greenColor);
                          }else{
                            CustomFunctions.showCustomSnackBar(text: 'Photo Saved Failed', context: context,backgroundColor: ColorsUtils.redColor,);

                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: CustomText(text: 'Save to Gallery', fontSize: 20.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: ColorsUtils.blackColor.withOpacity(0.8),
                          onPrimary: ColorsUtils.whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
