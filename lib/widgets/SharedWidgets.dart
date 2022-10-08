import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_cv/controllers/skills_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_config.dart';
import '../charts_sample_data.dart';
import '../controllers/projects_controller.dart';
import '../controllers/social_controller.dart';
import '../main.dart';

class SharedWidgets {
  static ChartDataLabelPosition _selectedLabelPosition = ChartDataLabelPosition.outside;

  static Widget sectionTitle(title) {
    return Container(
      // color: Color(0xFFFFFFFF),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Align(
          alignment: AlignmentDirectional.center,
          child: AutoSizeText.rich(
            TextSpan(
              style: Data.H1,
              children: [
                TextSpan(
                  text: "$title",
                ),
                // TextSpan(
                //   style: fontStyle.copyWith(color: Colors.blue),
                //   text: "  (${model.comments!.length})",
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static SfPyramidChart _buildPyramidSmartLabelChart() {
    return SfPyramidChart(
      onTooltipRender: (TooltipArgs args) {
        args.text = args.dataPoints![args.pointIndex!.toInt()].y.toString();
      },
      title: ChartTitle(text: 'Top 10 populated countries - 2019', textStyle: const TextStyle(fontSize: 14)),
      tooltipBehavior: TooltipBehavior(enable: true),
      // smartLabelMode: _mode,
      series: _getPyramidSeries(),
    );
  }

  static PyramidSeries<ChartSampleData, String> _getPyramidSeries() {
    final List<ChartSampleData> pieData = <ChartSampleData>[
      ChartSampleData(x: 'Mexico', y: 127575529, text: null, pointColor: const Color.fromRGBO(238, 238, 238, 1)),
      ChartSampleData(x: 'Russia ', y: 145872256, text: null, pointColor: const Color.fromRGBO(255, 240, 219, 1)),
      ChartSampleData(x: 'Bangladesh', y: 163046161, text: null, pointColor: const Color.fromRGBO(255, 205, 96, 1)),
      ChartSampleData(x: 'Nigeria ', y: 200963599, text: null, pointColor: const Color.fromRGBO(73, 76, 162, 1)),
      ChartSampleData(x: 'Brazil', y: 211049527, text: null, pointColor: const Color.fromRGBO(0, 168, 181, 1)),
      ChartSampleData(x: 'Pakistan ', y: 216565318, text: null, pointColor: const Color.fromRGBO(116, 180, 155, 1)),
      ChartSampleData(x: 'Indonesia', y: 270625568, text: null, pointColor: const Color.fromRGBO(248, 177, 149, 1)),
      ChartSampleData(x: 'US', y: 329064917, text: null, pointColor: const Color.fromRGBO(246, 114, 128, 1)),
      ChartSampleData(x: 'India', y: 1366417754, text: null, pointColor: const Color.fromRGBO(192, 108, 132, 1)),
      ChartSampleData(x: 'China', y: 1433783686, text: null, pointColor: const Color.fromRGBO(53, 92, 125, 1)),
    ];
    return PyramidSeries<ChartSampleData, String>(
        width: '60%',
        dataSource: pieData,
        xValueMapper: (ChartSampleData data, _) => data.x as String,
        yValueMapper: (ChartSampleData data, _) => data.y,
        textFieldMapper: (ChartSampleData data, _) => data.x as String,
        pointColorMapper: (ChartSampleData data, _) => data.pointColor,
        dataLabelSettings:
            DataLabelSettings(isVisible: true, labelPosition: _selectedLabelPosition, useSeriesColor: true));
  }

  static Widget skils_page(Skill_Controller skillController) {
    return ListView(
      children: [
        SharedWidgets.sectionTitle("Skills"),
        GetBuilder<Skill_Controller>(
          builder: (controller) {
            return Container(
              color: Colors.pink.shade200,
              child: SfCircularChart(
                title: ChartTitle(text: 'Known Languages'),
                legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                tooltipBehavior: controller.tooltipBehavior,
                series: <CircularSeries>[
                  RadialBarSeries<LangsData, String>(
                      dataSource: controller.chartDataLang,
                      xValueMapper: (LangsData data, _) => data.lang,
                      yValueMapper: (LangsData data, _) => data.percentage,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      maximumValue: 100)
                ],
              ),
            );
          },
        ),
        const SizedBox(
          height: 22,
        ),
        GetBuilder<Skill_Controller>(
          builder: (controller) {
            return Container(
              color: Colors.pink.shade200,
              child: SfCircularChart(
                title: ChartTitle(text: 'Known Technologies'),
                legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                tooltipBehavior: controller.tooltipBehavior,
                series: <CircularSeries>[
                  // RadialBarSeries<GDPData, String>(
                  //     dataSource: controller.chartData,
                  //     xValueMapper: (GDPData data, _) => data.lang,
                  //     yValueMapper: (GDPData data, _) => data.gdp,
                  //     dataLabelSettings: DataLabelSettings(isVisible: true),
                  //     enableTooltip: true,
                  //     maximumValue: 100),
                  PieSeries<TechsData, String>(
                    dataSource: controller.chartDataTech,
                    xValueMapper: (TechsData data, _) => data.tech,
                    yValueMapper: (TechsData data, _) => data.percentage,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    // maximumValue: 100
                  ),
                  // DoughnutSeries<GDPData, String>(
                  //     dataSource: controller.chartData,
                  //     xValueMapper: (GDPData data, _) => data.lang,
                  //     yValueMapper: (GDPData data, _) => data.gdp,
                  //     dataLabelSettings: DataLabelSettings(isVisible: true),
                  //     enableTooltip: true,
                  //     // maximumValue: 100
                  // ),
                ],
              ),
            );
          },
        ),
        Card(
          color: Colors.pink.shade200,
          child: Container(
            height: 100,
          ),
        ),
      ],
    );
  }

  static Widget skils_page2(Skill_Controller skillController) {
    return ListView(
      children: [
        SharedWidgets.sectionTitle("Skills"),
        GetBuilder<Skill_Controller>(
          builder: (controller) {
            return Container(
              color: Colors.pink.shade200,
              child: _buildPyramidSmartLabelChart(),
            );
          },
        ),
        const SizedBox(
          height: 22,
        ),
      ],
    );
  }

  static Widget projects_page(Projects_Controller projectsController) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SharedWidgets.sectionTitle("Projects"),
            Expanded(
              child: ListView.builder(
                itemCount: projectsController.user_repos.length,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return RepoItem(projectsController.user_repos, index);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  static Widget RepoItem(List<dynamic> resList, int index) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () {
          var url2 = "${resList[index]['html_url']}";
          launch(url2.toString());
        },
        child: Card(
          color: Colors.pink.shade50,
          elevation: 2,
          child: Column(
            children: [
              ListTile(
                // title: Text("${resList[index]['owner']['login']}"),
                title: Text(
                  "${resList[index]['name']}",
                  style: Data.T2,
                ),
                subtitle: Text(
                  "${resList[index]['language'] ?? "no info"}",
                  style: Data.SM4,
                ),
                isThreeLine: true,
                tileColor: Colors.white,
                // trailing: Text("Stars : ${resList[index]['stargazers_count']}"),

                leading: CircleAvatar(
                    backgroundColor: Colors.pink.shade200,
                    child: Text(
                      resList[index]['name'].toString().substring(0, 1),
                      style: Data.SM2,
                    )),
              ),
              ExpansionTile(
                  title: Text(
                    "${resList[index]["language"] ?? "no info"}",
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${resList[index]["owner"]['login'] ?? "no info"}",
                        style: Data.SM2,
                      ),
                    ),
                  ]),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ListTile(
              //     title:
              //     Text("${resList[index]['owner']['login']}"),
              //     leading: CircleAvatar(
              //       backgroundImage: NetworkImage(
              //           "${resList[index]['owner']['avatar_url']}"),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  static Widget social_page(Social_Controller socialController) {
    return Scaffold(
      body: Column(
        // shrinkWrap: true,
        // primary: false,
        // physics: NeverScrollableScrollPhysics(),

        children: <Widget>[
          SharedWidgets.sectionTitle("Contact"),
          Expanded(
            flex: 4,
            child: Container(
              // width: MediaQuery.of(context).size.width,
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.pink.shade200,
                    Colors.pink.shade100,
                  ],
                  begin: Alignment.center,
                  end: new Alignment(-1.0, -1.0),
                ),
              ),
              child: GetBuilder<Social_Controller>(builder: (logic) {
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: info(
                        profileName: 'Yaman Alkhateb',
                        jobDescription: 'Yaman Alkhateb',
                        location: 'Riyadh',
                        webLink: 'https://bio.link/manoooz',
                        profilePic: '',
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  static Widget social_page2(Social_Controller socialController) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // SharedWidgets.sectionTitle("Contact"),
          Expanded(
            flex: 4,
            child: Container(
              // width: MediaQuery.of(context).size.width,
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    Colors.pink.shade200,
                    Colors.pink.shade100,
                  ],
                  begin: Alignment.center,
                  end: new Alignment(-1.0, -1.0),
                ),
              ),
              child: GetBuilder<Social_Controller>(builder: (logic) {
                var user = logic.gitHubUser;
                return Column(
                  children: <Widget>[
                    // Stack(
                    //   children: [
                    //     Container(
                    //       // color: Colors.pink.shade200,
                    //       height: 200,
                    //       width: double.infinity,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.rectangle,
                    //         image: DecorationImage(
                    //           fit: BoxFit.cover,
                    //           image: AssetImage("assets/giphy.gif"),
                    //         ),
                    //       ),
                    //     ),
                    //     Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //
                    //       ],
                    //     ),
                    //     // Container(
                    //     //   color: Colors.black.withOpacity(0.5),
                    //     //   height: 200,
                    //     // ),
                    //   ],
                    // ),
                    Expanded(
                      child: info(
                          profileName: '${user.value?.name}',
                          jobDescription: 'Yaman Alkhateb',
                          location: '${user.value?.location}',
                          webLink: 'https://bio.link/manoooz',
                          profilePic: '${user.value?.avatarUrl}'),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  static Widget social_page3(Social_Controller socialController) {
    var user = socialController.gitHubUser.value;

    return FutureBuilder(
        future: socialController.getUserInfo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  height: 20,
                ),
                // avatarUrl
                FadeInUp(
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    // color: Colors.green,
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      radius: 0.5,
                      backgroundImage: NetworkImage("${user!.avatarUrl}"),
                    ),
                  ),
                ),

                Container(
                  height: 50,
                  child: // name
                      FadeInDown(
                    child: Center(
                      child: Text(
                        "${user!.name}",
                        style: Data.T2,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.pink.shade200,
                            style: BorderStyle.solid,
                            width: 4,
                            strokeAlign: StrokeAlign.inside),
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                      ),
                      height: 200,
                      width: Get.width,
                      // color: Colors.white,
                      child: Column(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 100,
                              width: Get.width,
                              // color: Colors.pink.shade200,
                              child: Flexible(
                                child: AutoSizeText(
                                  "${user!.bio}",
                                  maxFontSize: 22,
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                  style: Data.T2,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: Container(
                              // color: Colors.red,
                              height: 200,
                              child: Column(
                                children: [
                                  // location

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      FadeInLeft(
                                        child: Text(
                                          "location :",
                                          style: Data.SM2,
                                        ),
                                      ),
                                      FadeInLeft(
                                          child: Text(
                                        "${user!.location}",
                                        style: Data.T2,
                                      )),
                                    ],
                                  ),
                                  // followers

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      FadeInRight(
                                        child: Text(
                                          "followers :",
                                          style: Data.SM2,
                                        ),
                                      ),
                                      FadeInRight(
                                        child: Text(
                                          "${user!.followers}",
                                          style: Data.T2,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // following
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      FadeInRight(
                                        child: Text(
                                          "following :",
                                          style: Data.SM2,
                                        ),
                                      ),
                                      FadeInRight(
                                        child: Text(
                                          "${user!.following}",
                                          style: Data.T2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // SOCIAL_LINKS
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: socialLinks(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  static Widget info(
      {required String profileName,
      required String jobDescription,
      required String location,
      required String webLink,
      required String profilePic}) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              opacity: 0.6,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.colorDodge),
              fit: BoxFit.fill,
              image: AssetImage("assets/giphy.gif"),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: social_controller.width,
                height: social_controller.height,
                decoration: BoxDecoration(
                  shape: social_controller.shape,
                  image: DecorationImage(
                    opacity: 0.8,
                    scale: 3,
                    // colorFilter: ColorFilter.mode(Colors.black, BlendMode.colorDodge),
                    fit: BoxFit.fill,
                    image: NetworkImage(profilePic),
                  ),
                ),
              ),
              Center(
                child: Text(
                  profileName,
                  style: Data.H1,
                ),
              ),
              const SizedBox(width: 10.0),
              Center(
                child: Text(
                  jobDescription,
                  style: Data.S1,
                ),
              ),
              const SizedBox(width: 10.0),
              InkWell(
                child: Text(
                  location,
                  style: Data.S1,
                ),
                onTap: () {
                  social_controller.openMap();
                },
              ),
              InkWell(
                child: Text(
                  webLink,
                  style: Data.S1,
                ),
                onTap: () {
                  social_controller.openURL(webLink);
                },
              ),
              socialLinks(),
            ],
          ),
        ),
      ],
    );
  }

  static Padding socialLinks() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Icon(FontAwesomeIcons.telegram, color: Colors.pink.shade200, size: 35.0),
              onTap: () {
                social_controller.telegramURL("MaNoOoz");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Icon(FontAwesomeIcons.github, color: Colors.pink.shade200, size: 35.0),
              onTap: () {
                social_controller.githubURL("MaNoOoz");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Icon(FontAwesomeIcons.twitter, color: Colors.pink.shade200, size: 35.0),
              onTap: () {
                social_controller.twitterURL("MaNoOoz77");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Icon(FontAwesomeIcons.googlePlay, color: Colors.pink.shade200, size: 35.0),
              onTap: () {
                social_controller.googleplayURL("8389389659889758696");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Icon(FontAwesomeIcons.youtube, color: Colors.pink.shade200, size: 35.0),
              onTap: () {
                social_controller.youtubeURL("UCYuo5V0GKQGCStTQBGJQNVQ");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Icon(FontAwesomeIcons.linkedinIn, color: Colors.pink.shade200, size: 35.0),
              onTap: () {
                social_controller.linkedinURL("MaNoOoz");
              },
            ),
          ),
        ],
      ),
    );
  }
}
