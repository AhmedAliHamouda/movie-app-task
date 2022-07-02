import 'package:flutter/material.dart';
import 'package:movies_app_task/models/person_detail_model.dart';
import 'package:movies_app_task/models/person_images_model.dart';
import 'package:movies_app_task/ui/widgets/custom_text.dart';
import 'package:movies_app_task/ui/widgets/person_images_widget.dart';
import 'package:movies_app_task/utils/colors_utils.dart';
import 'package:movies_app_task/network/service_urls.dart';

class PersonDetailWidget extends StatefulWidget {
  final PersonImagesModel? personImagesModel;
  final PersonDetailModel? personDetailModel;

  const PersonDetailWidget({Key? key, required this.personDetailModel, required this.personImagesModel}) : super(key: key);

  @override
  _PersonDetailWidgetState createState() => _PersonDetailWidgetState();
}

class _PersonDetailWidgetState extends State<PersonDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            color: Colors.black54,
          ),
          margin: const EdgeInsets.only(
            top: 130,
          ),
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 40, right: 10),
          child: Text(
            widget.personDetailModel!.name ?? '',
            textAlign: TextAlign.end,
            style: const TextStyle(fontSize: 25, color: Colors.white),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 50, left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.personDetailModel!.profilePath == null
                    ? ''
                    : ServicesURLs.mainImageUrlw200 + widget.personDetailModel!.profilePath!),
                radius: 60,
                backgroundColor: ColorsUtils.blackColor,
              ),
              Column(
                children: [
                  const Text(
                    'POPULARITY',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.personDetailModel!.popularity.toString() + ' K',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _customColumn('DATE OF BIRTH',widget.personDetailModel!.birthday??''),
              _customColumn('DATE OF DEATH',widget.personDetailModel!.deathday??'----------------'),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'PlACE OF BIRTH',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                widget.personDetailModel!.placeOfBirth ?? '',
                style: const TextStyle(fontSize: 15, letterSpacing: 1, wordSpacing: 2),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 5, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'BIOGRAPHY',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                widget.personDetailModel!.biography ?? '',
                style: const TextStyle(
                    fontSize: 13, wordSpacing: 1, height: 1.2, fontStyle: FontStyle.normal),
              ),
            ],
          ),
        ),
        PersonImagesWidget(personImagesModel: widget.personImagesModel!),
      ],
    );
  }

  Widget _customColumn(String name,String subName) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          subName,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
