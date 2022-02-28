import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LangsData {
  LangsData(this.lang, this.percentage);

  final String lang;
  final int percentage;
}

class TechsData {
  TechsData(this.tech, this.percentage);

  final String tech;
  final int percentage;
}

class Skill_Controller extends GetxController {
  late List<LangsData> chartDataLang;
  late List<TechsData> chartDataTech;

  late TooltipBehavior tooltipBehavior;

  List<LangsData> getChartDataLang() {
    final List<LangsData> chartData = [
      LangsData('Java', 99),
      LangsData('Dart', 100),
      LangsData('Python', 55),
      LangsData('Html', 80),
      LangsData('Java Script', 33),
      LangsData('Php', 1),
    ];
    return chartData;
  }

  List<TechsData> getChartDataTech() {
    final List<TechsData> chartData = [
      TechsData('Android Studio', 99),
      TechsData('VS Code', 100),
      TechsData('Intellij', 55),
      TechsData('Firebase', 80),
      TechsData('Google Cloud Platform', 33),
      TechsData('My SQL', 45),
    ];
    return chartData;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    chartDataLang = getChartDataLang();
    chartDataTech = getChartDataTech();
    tooltipBehavior = TooltipBehavior(enable: true);
  }
}
