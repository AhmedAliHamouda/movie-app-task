import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app_task/ui/widgets/custom_text.dart';
import 'package:movies_app_task/ui/widgets/custom_popular_widget.dart';
import 'package:movies_app_task/ui/widgets/loading_widget.dart';
import 'package:movies_app_task/utils/colors_utils.dart';
import 'package:movies_app_task/viewModels/global_riverpod_container.dart';
import 'package:movies_app_task/viewModels/person_riverpod.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int pageIndex = 1;

  void _startScrollListener() async {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        pageIndex++;
        await providerContainer.read(personRiverPod).getPopularPeopleDataByPage(pageIndex);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      await providerContainer.read(personRiverPod).getPopularPeopleData(pageIndex);
      _startScrollListener();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackGroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: 'Movies App',
        ),
        backgroundColor: ColorsUtils.blackColor,
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final dataProv = ref.watch(personRiverPod);
            return Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 7.0,
                      ),
                      const CustomText(
                        text: 'Popular People',
                        fontSize: 20.0,
                        color: ColorsUtils.blackColor,
                        fontWeight: FontWeight.w800,
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      dataProv.loading
                          ? const Flexible(
                              child: LoadingWidget(),
                            )
                          : Flexible(
                              child: dataProv.listActors == null
                                  ? const Center(
                                      child: Text('Error Found'),
                                    )
                                  : dataProv.listActors!.isEmpty
                                      ? const Center(
                                          child: CustomText(
                                            text: 'No Popular People Found',
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : ListView.builder(
                                          controller: _scrollController,
                                          shrinkWrap: true,
                                          itemCount: dataProv.listActors!.length,
                                          itemBuilder: (context, index) {
                                            return CustomPopularWidget(
                                                actorData: dataProv.listActors![index]);
                                          },
                                        ),
                            ),
                      const SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
                if (dataProv.loadingByPage)
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsUtils.blackColor.withOpacity(0.7),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: const SizedBox(
                          width: 25.0,
                          height: 25.0,
                          child: LoadingWidget(
                            color: ColorsUtils.whiteColor,
                          )),
                    ),
                    bottom: 30.0,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
