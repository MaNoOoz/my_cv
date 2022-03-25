import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_cv/controllers/skills_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_config.dart';
import '../controllers/projects_controller.dart';
import '../controllers/social_controller.dart';
import '../main.dart';

class SharedWidgets {
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

  static Widget skils_page(Skill_Controller skill_Controller) {
    return Expanded(
      child: ListView(
        children: [
          SharedWidgets.sectionTitle("Skills"),
          GetBuilder<Skill_Controller>(
            builder: (controller) {
              return SfCircularChart(
                title: ChartTitle(text: 'Known Languages'),
                legend: Legend(
                    isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                tooltipBehavior: controller.tooltipBehavior,
                series: <CircularSeries>[
                  RadialBarSeries<LangsData, String>(
                      dataSource: controller.chartDataLang,
                      xValueMapper: (LangsData data, _) => data.lang,
                      yValueMapper: (LangsData data, _) => data.percentage,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      maximumValue: 100)
                ],
              );
            },
          ),
          GetBuilder<Skill_Controller>(
            builder: (controller) {
              return SfCircularChart(
                title: ChartTitle(text: 'Known Technologies'),
                legend: Legend(
                    isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
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
                    dataLabelSettings: DataLabelSettings(isVisible: true),
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
      ),
    );
  }

  static Widget projects_page(Projects_Controller projects_controller) {
    var resList = projects_controller.user_repos;
    // print("resList : ${resList.length}");
    return Scaffold(
        appBar: AppBar(
          title: SharedWidgets.sectionTitle("Projects"),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Object>(
            // initialData: projects_controller.user_repos,
            future: projects_controller.getUserRepos(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: resList.length,
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return RepoItem(resList, index);
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "${snapshot.error.toString()}",
                        style: TextStyle(color: Colors.pink, fontSize: 16),
                      )
                    ]);
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.pink.shade200,
                ));
              }
            },
          ),
        ));
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
                      "${resList[index]['name'].toString().substring(0, 1)}",
                      style: Data.SM2,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${resList[index]["description"] ?? "no info"}",
                  style: Data.SM2,
                ),
              ),
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

  static Widget social_page(Social_Controller social_controller) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              // width: MediaQuery.of(context).size.width,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  // gradient: new LinearGradient(
                  //   colors: [
                  //     Colors.pink.shade200,
                  //     Colors.pink.shade100,
                  //   ],
                  //   begin: Alignment.center,
                  //   end: new Alignment(-1.0, -1.0),
                  // ),
                  ),
              child: GetBuilder<Social_Controller>(builder: (logic) {
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
                      child: info("Yaman Alkhateb", "Flutter Developer",
                          "Riyadh", "https://bio.link/manoooz"),
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

  static Widget info(String profileName, String jobDescription, String location,
      String webLink) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: const DecorationImage(
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
                  image: const DecorationImage(
                    opacity: 0.9,
                    // colorFilter: ColorFilter.mode(Colors.black, BlendMode.colorDodge),
                    fit: BoxFit.fill,
                    image: AssetImage("assets/2.jpeg"),
                  ),
                ),
              ),
              Center(
                child: Text(
                  profileName,
                  style: Data.H1,
                ),
              ),
              SizedBox(width: 10.0),
              Center(
                child: Text(
                  jobDescription,
                  style: Data.S1,
                ),
              ),
              SizedBox(width: 10.0),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Icon(FontAwesomeIcons.telegram,
                            color: Colors.pink.shade200, size: 35.0),
                        onTap: () {
                          social_controller.telegramURL("MaNoOoz");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Icon(FontAwesomeIcons.github,
                            color: Colors.pink.shade200, size: 35.0),
                        onTap: () {
                          social_controller.githubURL("MaNoOoz");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Icon(FontAwesomeIcons.twitter,
                            color: Colors.pink.shade200, size: 35.0),
                        onTap: () {
                          social_controller.twitterURL("MaNoOoz77");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Icon(FontAwesomeIcons.googlePlay,
                            color: Colors.pink.shade200, size: 35.0),
                        onTap: () {
                          social_controller
                              .googleplayURL("8389389659889758696");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Icon(FontAwesomeIcons.youtube,
                            color: Colors.pink.shade200, size: 35.0),
                        onTap: () {
                          social_controller
                              .youtubeURL("UCYuo5V0GKQGCStTQBGJQNVQ");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Icon(FontAwesomeIcons.linkedinIn,
                            color: Colors.pink.shade200, size: 35.0),
                        onTap: () {
                          social_controller.linkedinURL("MaNoOoz");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
