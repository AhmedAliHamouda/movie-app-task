import 'package:flutter/material.dart';
import 'package:movies_app_task/models/popular_people_model.dart';
import 'package:movies_app_task/ui/person_detail_screen.dart';
import 'package:movies_app_task/ui/widgets/custom_text.dart';
import 'package:movies_app_task/utils/colors_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app_task/utils/routes.dart';
import 'package:movies_app_task/network/service_urls.dart';


class CustomPopularWidget extends StatelessWidget {
  final Results actorData;
  const CustomPopularWidget({required this.actorData,Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 6.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,),
        child: ListTile(
          onTap: (){
            CustomNavigator.pushScreen(widget: PersonDetailScreen(id: actorData.id!), context: context);

          },
          contentPadding: EdgeInsets.zero,
          leading: Container(
            height: 100.0,
            width: 60.0,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsUtils.borderColor.withOpacity(0.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: CachedNetworkImage(
                //cacheManager: CustomCacheManager2.cacheManager,
                imageUrl:actorData.profilePath==null?'':ServicesURLs.mainImageUrlw200+actorData.profilePath!,
                placeholder: (context, url) => const CircularProgressIndicator(backgroundColor: ColorsUtils.blackColor,color: ColorsUtils.whiteColor,),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title:  CustomText(
            text: '${actorData.name}',
            color: ColorsUtils.blackColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
          ),
          subtitle:  CustomText(
            text: '${actorData.knownForDepartment}',
            color: ColorsUtils.blackColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
