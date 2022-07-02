import 'package:flutter/material.dart';
import 'package:movies_app_task/models/person_images_model.dart';
import 'package:movies_app_task/ui/image_screen.dart';
import 'package:movies_app_task/ui/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app_task/utils/colors_utils.dart';
import 'package:movies_app_task/utils/routes.dart';
import 'package:movies_app_task/network/service_urls.dart';

class PersonImagesWidget extends StatelessWidget {
  final PersonImagesModel personImagesModel;
  const PersonImagesWidget({Key? key, required this.personImagesModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'PHOTOS',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          (personImagesModel.profiles!.isEmpty)? Container(
            alignment: Alignment.center,
            height: 100,
            child: const CustomText(text: 'No Photos Found',fontSize: 18.0,),
          ) :GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10),
              itemCount:personImagesModel.profiles!.length,
              itemBuilder: (BuildContext ctx, index) {
                return InkWell(
                  onTap: (){
                    CustomNavigator.pushScreen(widget: ImageScreen(imagePath: personImagesModel.profiles![index].filePath!), context: context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: CachedNetworkImage(
                      imageUrl:
                          ServicesURLs.mainImageUrlw200 + personImagesModel.profiles![index].filePath!,
                      placeholder: (context, url) => Container(color: ColorsUtils.blackColor),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
