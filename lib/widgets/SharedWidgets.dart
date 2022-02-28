import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_cv/controllers/skills_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_config.dart';
import '../controllers/projects_controller.dart';

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
              style: Data.HEADLINE1,
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

  static Widget profile_page(Projects_Controller projects_controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Container(
            height: 40,
          ),
          // image
          SizedBox(
            // color: Colors.green,
            height: 150,
            width: 150,
            child: GestureDetector(
              onTap: () {
                var url = "https://www.linkedin.com/in/yaman-alkhateb/";
                launch(url.toString());
              },
              child: Image.asset('assets/2.jpeg',
                  // fit: BoxFit.cover,
                  fit: BoxFit.contain,
                  color: Colors.black87.withOpacity(0.7),
                  colorBlendMode: BlendMode.color),
            ),
          ),

          // name
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Yaman Al Khateeb",
                    style: Data.HEADLINE1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Mobile Developer / Software Engineer",
                    style: Data.SMALL2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // body: Home(),
    );
  }

  static Widget projects_page(Projects_Controller projects_controller) {
    var resList = projects_controller.user_repos;
    print("${resList.length}");
    return Scaffold(
      appBar: AppBar(
        title: SharedWidgets.sectionTitle("Projects"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<dynamic>>(
              initialData: projects_controller.user_repos,
              future: projects_controller.getUserRepos(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  // childAspectRatio: 15,
                                  crossAxisCount: (1)),
                          itemCount: resList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: GestureDetector(
                                onTap: () {
                                  var url2 = "${resList[index]['html_url']}";
                                  launch(url2.toString());
                                },
                                child: Container(
                                  height: 300,
                                  child: Card(
                                    elevation: 2,
                                    child: GridTile(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            // title: Text("${resList[index]['owner']['login']}"),
                                            title: Text(
                                              "${resList[index]['name']}",
                                              style: Data.TITLE2,
                                            ),
                                            subtitle: Text(
                                              "${resList[index]['language'] ?? "no info"}",
                                              style: Data.SMALL3,
                                            ),
                                            isThreeLine: true,
                                            tileColor: Colors.white,
                                            // trailing: Text("Stars : ${resList[index]['stargazers_count']}"),

                                            leading: CircleAvatar(
                                                backgroundColor:
                                                    Colors.pink.shade200,
                                                child: Text(
                                                  "${resList[index]['name'].toString().substring(0, 1)}",
                                                  style: Data.SMALL2,
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${resList[index]["description"] ?? "no info"}",
                                              style: Data.SMALL2,
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
                                      footer: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // IconButton(onPressed: ()=>print(""),icon: Icon(Icons.message),),
                                          // IconButton(onPressed: ()=>print(""),icon: Icon(Icons.message),),
                                          // IconButton(onPressed: ()=>print(""),icon: Icon(Icons.message),),
                                        ],
                                      ),
                                      header: Container(
                                        height: 3,
                                        color: Colors.pink.shade200,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
              })),
    );
  }

  static Widget social_page() {
    return Column(
      children: [
        SharedWidgets.sectionTitle("Social"),
        Card(
          color: Colors.pink.shade200,
          child: Container(
            height: 100,
          ),
        ),
      ],
    );
  }
}
